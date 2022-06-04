//
//  ContentModel.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/28/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ContentModel: ObservableObject {
    
    // List of user data
    @Published var user = [User]()
    
    // Authentication
    @Published var loggedIn = false
    
    // Reference to Cloud Firestore database
    let db = FirebaseFirestore.Firestore.firestore()
    
    // List of posts
    @Published var posts = [Post]()
    
    init() {
        
        // Get recent posts
        getRecentPosts()        
    }
    
    // MARK: Authentication Methods
    func checkLogin() {
        
        // Check if there's a current user
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // TODO: Check if user meta data has been fetched
    }
    
    // MARK: Data Retrieval Methods
    
    // Get user data
    func getUserData() {
        
        // Fetch data from Firestore
        let userId = Auth.auth().currentUser?.uid
        let users = db.collection("users").document(userId!)
        
        users.getDocument { docSnapshot, error in
            
            // Create array of current user's data
            var user = [User]()
            
            // If document snapshot contains data & no errors are returned
            if error == nil && docSnapshot != nil {
             
                // Create new user instance
                let u = User()
                
                // Extract fields from document snapshot
                u.name = docSnapshot?.get("name") as? String ?? ""
                u.username = docSnapshot?.get("username") as? String ?? ""
                
                // Extract map from document snapshot
                let profileMap = docSnapshot?.get("profile") as! [String: Any]
                
                u.bio = profileMap["bio"] as? String ?? ""
                u.pfp = profileMap["pfp"] as? String ?? ""
                
                user.append(u)
            }
            else if error != nil {
                // Print errors
                print(error!.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
    // Get user's feed
    func getRecentPosts() {
        
        // Specify path
        let recentPostCollection = db.collection("post")
        
        // Get documents
        recentPostCollection.getDocuments { querySnapshot, error in
            
            if error == nil && querySnapshot != nil {
                
                // Create an array for posts
                var recentPosts = [Post]()
                
                for doc in querySnapshot!.documents {
                    
                    // Create new post instance
                    var p = Post()
                    
                    // Parse values from doc into post instance
                    p.id = doc["id"] as? String ?? UUID().uuidString
                    p.body = doc["body"] as? String ?? ""
                    p.commentCount = doc["commentCount"] as? Int ?? 0
                    p.likeCount = doc["likeCount"] as? Int ?? 0
                    
                    recentPosts.append(p)
                    print("Recent posts: \(recentPosts)")
                }
                
                // Assign posts to published property
                DispatchQueue.main.async {
                    
                    self.posts = recentPosts
                }
            }
            else {
                print("------ Error")
            }
        }
    }
    
    // MARK: Data Mutation Methods
    func updateProfile(bio: String?, pfp: String?) {
        let users = db.collection("users")
        
        // Check that currentUser is not nil
        if let userId = Auth.auth().currentUser?.uid {
            
            // Update profile info
            users.document(userId).updateData(["profile": [
                "bio": bio ?? "",
                "pfp": pfp ?? ""
            ]])
        }
    }
}
