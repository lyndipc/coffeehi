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
    
    // Reference to Cloud Firestore
    let db = FirebaseFirestore.Firestore.firestore()
    
    // List of user data
    @Published var user = [User]()
    
    // Authentication
    @Published var loggedIn = false
    
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
        
        // Check if user meta data has been fetched
        if UserService.shared.user.name == "" {
            getUserData()
        }
    }
    
    
    // MARK: Data Retrieval Methods
    
    // Get user data
    func getUserData() {
        
        // Fetch data from Firestore
        if let userId = Auth.auth().currentUser?.uid {
            
            let users = db.collection("users").document(userId)
            
            users.getDocument { docSnapshot, error in
                
                // Create array of current user's data
                let user = UserService.shared.user
                
                // If document snapshot contains data & no errors are returned
                guard error == nil, docSnapshot != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Extract fields from document snapshot
                user.name = docSnapshot?.get("name") as? String ?? ""
                user.username = docSnapshot?.get("username") as? String ?? ""
                
                // Extract map from document snapshot
                let profileMap = docSnapshot?.get("profile") as! [String: Any]
                
                user.bio = profileMap["bio"] as? String ?? ""
                user.pfp = profileMap["pfp"] as? String ?? ""
            }
        }
        else {
            
            return
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
        
        // Check that there is a valid user
        if let userId = Auth.auth().currentUser?.uid {
            
            // Save user's profile locally
            let user = UserService.shared.user
            
            user.bio = bio ?? ""
            user.pfp = pfp ?? ""
            
            print(user)
            
            // Update profile info in firestore
            let users = db.collection("users")
            users.document(userId).updateData(["profile": [
                "bio": bio ?? "",
                "pfp": pfp ?? ""
            ]])
        }
    }
}
