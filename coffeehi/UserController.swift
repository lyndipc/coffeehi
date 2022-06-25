//
//  UserController.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/25/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// TODO: getUserData no longer calls getRecentPosts --> add to FeedView

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
    
    
    // MARK: User Data Retrieval
    
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
    
    
    // MARK: Create User Data
    
    // Follow a user
    func followUser(followedUser: String?) {
        
        // Check currentUser is valid
        guard Auth.auth().currentUser != nil else {
            print("User not authenticated")
            return
        }
        
        // TODO: Add followedUser to currentUser's Following map
        
        // TODO: Add currentUser to followedUser's Followers map
    }
    
    
    // MARK: Update User Data
    
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
