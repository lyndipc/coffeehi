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
    
    // Instance of user's following data
    @Published var following = [Following]()
    
    // Authentication state
    @Published var loggedIn = false
    
    
    // MARK: Authentication Methods
    
    // Check if user is authenticated before displaying view
    @MainActor
    func checkLogin() async {
        
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // Fetch user metadata if missing
        if UserService.shared.user.name == "" {
            await self.getUserData()
        }
    }
    
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
    
    @MainActor
    func getUserData() async {
            
        // Check currently authenticated user
        if let userId = Auth.auth().currentUser?.uid {
            
            let users = db.collection("users").document(userId)
            
            do {
                
                // Create user struct to temporarily store retrieved data
                var u = User()
                
                let userDocuments = try await users.getDocument().data()
                guard let docs = userDocuments else {
                    return
                }
                
                // Extract data and store in temporary struct
                u.id = userId
                u.name = docs["name"] as? String ?? ""
                u.username = docs["username"] as? String ?? ""
                
                let profile = docs["profile"] as! [String: Any]
                u.bio = profile["bio"] as? String ?? ""
                u.pfp = profile["pfp"] as? String ?? ""
                
                // Store user data in environment object
                self.user.append(u)
                
                // Store user data locally
                UserService.shared.user = u
                
                // TODO: Create followers collection query
                await self.getFollowData()
            }
            catch {
                print("Something bad happened")
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getFollowData() async {
        
        if let userId = Auth.auth().currentUser?.uid {
   
            let users = db.collection("users").document(userId)
            
            do {
                var f = Following()
   
                // Extract following data from collection
                let followingDocs = try await users.collection("following").getDocuments()

                for doc in followingDocs.documents {
                    f.id = doc.documentID
                    f.name = doc["name"] as? String ?? ""
                    f.username = doc["username"] as? String ?? ""
                    f.pfp = doc["pfp"] as? String ?? ""

                    self.following.append(f)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        else {
            return
        }
    }
    
    // MARK: Data Creation Methods
    
    @MainActor
    func followUser(followedUser: String?, followedUserId: String?, followedUserPfp: String?) async {
        
        // Check currentUser is valid
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
            
            do {
                // Add followed user's data to current user's collection
                try await userDoc.setData(followingData)
            }
            catch {
                print(error.localizedDescription)
            }
            
            // Create new object from currentUser's data
            let followerData: [String: Any] = [
                "name": UserService.shared.user.name,
                "username": UserService.shared.user.username,
                "pfp": UserService.shared.user.pfp
            ]
            
            // Add current user's id to the followed user's followers collection
            let followedUserDoc = db.collection("users").document(followedUserId!).collection("followers").document(userId)
            
            do {
                try await followedUserDoc.setData(followerData)
            }
            catch {
                print(error.localizedDescription)
            }
            
        } else {
            return
        }
    }
    
    
    // MARK: Data Mutation Methods
    
    @MainActor
    func updateProfile(bio: String?, pfp: String?) async -> Void {
        
        // Check for valid user
        if let userId = Auth.auth().currentUser?.uid {
            
            // Create dict of profile data
            let profileData = [
                "bio": bio ?? "",
                "pfp": pfp ?? ""
            ]
            
            do {
                // Update profile info in db
                try await db.collection("users").document(userId).updateData(["profile": profileData])
            }
            catch {
                print(error.localizedDescription)
            }
            
            // Update profile in UI
            await self.getUserData()
        }
        else {
            return
        }
    }
}
