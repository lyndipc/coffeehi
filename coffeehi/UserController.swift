//
//  UserController.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/25/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserController: ObservableObject {
    
    // Reference to Firestore
    private let db = FirebaseFirestore.Firestore.firestore()
    
    // Instance of user data
    @Published var user = [User]()
    
    // Authentication state
    @Published var loggedIn = false
    
    
    // MARK: Authentication Methods
    
    // Check if user is authenticated before displaying view
    func checkLogin() {
        
        // Check if there's a current user authenticated
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // Fetch user metadata if missing
        if UserService.shared.user.name == "" {
            self.getUserData()
        }
    }
    
    // Sign out currently authenticated user
    func signOut() {
        
        do {
            try Auth.auth().signOut()
            
            // Update UI when user is successfully signed out
            DispatchQueue.main.async {
                self.loggedIn = false
            }
        } catch {
            // TODO: Add error message for UI
            print("Problem signing out user")
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: Data Retrieval Methods
    
    // Get all data for authenticated user
    func getUserData() {
        
        // Fetch currently authenticated user data from Firestore
        if let userId = Auth.auth().currentUser?.uid {
            
            // Create user instance and empty user list
            var user = [User]()
            var u = User()
            
            var temp: [String: Any] = [:]
            var f = Following()
            
            // Create reference to user document
            let users = db.collection("users").document(userId)
            
            // Retrive user document
            users.getDocument { docSnapshot, error in
                
                // Check snapshot contains no errors
                guard error == nil, docSnapshot != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Extract fields from docSnapshot and store
                u.id = userId
                u.name = docSnapshot?.get("name") as? String ?? ""
                u.username = docSnapshot?.get("username") as? String ?? ""
                u.followingList = temp
                
                // Extract map from docSnapshot
                let profileMap = docSnapshot?.get("profile") as! [String: Any]
                
                // Store remaining profile data
                u.bio = profileMap["bio"] as? String ?? ""
                u.pfp = profileMap["pfp"] as? String ?? ""
                
                
                // Append all data to empty array
                user.append(u)
                
                DispatchQueue.main.async {
                    
                    // Store user data locally
                    UserService.shared.user = u
                    
                    // Store data in environment object
                    self.user = user
                }
            }
            
            // TODO: Add following to user data
            // Extract following data from collection
            users.collection("following").getDocuments { querySnapshot, error in

                guard error == nil, querySnapshot != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                for doc in querySnapshot!.documents {
                    f.id = doc.documentID
                    f.name = doc["name"] as? String ?? ""
                    f.username = doc["username"] as? String ?? ""
                    f.pfp = doc["pfp"] as? String ?? ""
                    
                    temp[f.id] = f
                }
            }
            
            // TODO: Create followers collection query
            
        } else {
            return
        }
    }
    
    
    // MARK: Data Creation Methods
    
    // Follow a user
    func followUser(followedUser: String?, followedUserId: String?, followedUserPfp: String?) {
        
        // Check currentUser is valid & create userId property
        if let userId = Auth.auth().currentUser?.uid {
            
            // Check that the user attempting to be followed is valid
            guard followedUserId != nil, followedUser != nil, followedUserPfp != nil else {
                print("ERROR: Cannot follow user. User not found.")
                return
            }
            
            // Check that followed user is not the same as current user
            guard followedUserId != userId else {
                print("Cannot follow yourself")
                return
            }
            
            // TODO: Limit how many users can be followed in a given amount of time
            
            // Create a document referencing the followed user's id in the current user's following collection
            let userDoc = db.collection("users").document(userId).collection("following").document(followedUserId!)
            
            // Create new object from followed user's data
            let followingData: [String: Any] = [
                "name": followedUser ?? "",
                "username": "sampleUserName",
                "pfp": followedUserPfp ?? ""
            ]
            
            // Add followed user's data to current user's collection
            userDoc.setData(followingData) { error in
                if error != nil {
                    print("Problem following user!")
                    print(error!.localizedDescription)
                } else {
                    print("Followed user!")
                }
            }
            
            // Create new object from currentUser's data
            let followerData: [String: Any] = [
                "name": UserService.shared.user.name,
                "username": UserService.shared.user.username,
                "pfp": UserService.shared.user.pfp
            ]
            
            // Add current user's id to the followed user's followers collection
            let followedUserDoc = db.collection("users").document(followedUserId!).collection("followers").document(userId)
            followedUserDoc.setData(followerData) { error in
                
                if error != nil {
                    print("Problem adding followed user")
                    print(error!.localizedDescription)
                } else {
                    print("Added new follower!")
                }
            }
            
        } else {
            return
        }
    }
    
    
    // MARK: Data Mutation Methods
    
    // Update user's profile
    func updateProfile(bio: String?, pfp: String?) {
        
        // Check for valid user
        if let userId = Auth.auth().currentUser?.uid {
            
            // Create dict of profile data
            let profileData = [
                "bio": bio ?? "",
                "pfp": pfp ?? ""
            ]
            
            // Update profile info in db
            db.collection("users").document(userId).updateData(["profile": profileData])
            
            // Update profile in UI
            DispatchQueue.main.async {
                self.getUserData()
            }
        }
    }
}
