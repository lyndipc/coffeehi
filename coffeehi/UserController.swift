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
            
            // Create reference to user document
            let users = db.collection("users").document(userId)
            
            // Retrive user document
            users.getDocument { docSnapshot, error in
                
                // Create user instance and empty user list
                var user = [User]()
                var u = User()
                
                // Check snapshot contains no errors
                guard error == nil, docSnapshot != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Extract fields from docSnapshot and store
                u.id = docSnapshot?.get("id") as? String ?? ""
                u.name = docSnapshot?.get("name") as? String ?? ""
                u.username = docSnapshot?.get("username") as? String ?? ""
                
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
        }
        else {
            return
        }
    }
    
    
    // MARK: Data Creation Methods
    
    // Follow a user
    func followUser(followedUser: String?, followedUserId: String?, followedUserPfp: String?) {
        
        // Check currentUser is valid
        if let userId = Auth.auth().currentUser?.uid {
            
            // TODO: Add followedUser to currentUser's Following map
            // Create new map of followed user information
            let newFollow = [
                "\(followedUserId ?? "Unknown")": [
                    "name": followedUser ?? "Some person",
                    "pfp": followedUserPfp ?? "pfp"
                ]
            ]
            
            // TODO: Prevent user from following themselves
            // TODO: Limit how many users can be followed in a given amount of time
            
            // Ref to user doc
            let userDoc = db.collection("users").document(userId)
            
            // Add map to "Following" array
            userDoc.setData(["following": FieldValue.arrayUnion([newFollow])], merge: true) { error in
                
                if error != nil {
                    print("Problem following user")
                    print(error!.localizedDescription)
                } else {
                    print("Followed user!")
                }
            }
            
            // Create new follower from currentUser
            let newFollower = [
                "\(userId)": [
                    "name": UserService.shared.user.name,
                    "pfp": UserService.shared.user.pfp
                ]
            ]
            
            // TODO: Add currentUser to followedUser's Followers map
            let followedUserDoc = db.collection("users").document(followedUserId!)
            followedUserDoc.setData(["followers": FieldValue.arrayUnion([newFollower])], merge: true) { error in
                
                if error != nil {
                    print("Problem adding followed user")
                    print(error!.localizedDescription)
                } else {
                    print("Added new follower!")
                }
            }
            
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
