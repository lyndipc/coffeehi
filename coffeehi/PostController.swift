//
//  PostController.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/25/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// TODO: Photo upload method

// TODO: Share content method

// TODO: Get draft posts method (and display in List)

class PostController: ObservableObject {
    
    // Reference to database
    let db = FirebaseFirestore.Firestore.firestore()
    
    // List of posts
    @Published var posts: [Post] = [Post]()
    
    // Post body instance
    private var postBody: String?
    
    
    // MARK: Data Retrieval Methods
    
    // Get user's feed of recent posts
    func getRecentPosts() {
        
        // Specify path
        let recentPostCollection = db.collection("post")
        
        // Get documents
        recentPostCollection.getDocuments { querySnapshot, error in
            
            // Check for errors retrieving documents
            guard error == nil, querySnapshot != nil else {
                print("Error retrieving post data")
                print(error!.localizedDescription)
                return
            }
            
            // Crate a Post array
            var post = [Post]()
            
            // Store post data in local instance
            for doc in querySnapshot!.documents {
                
                // Create post instance to store each of the post property values
                var p = Post()
                    
                    // Parse values from doc into post instance
                    p.id = doc["id"] as? String ?? UUID().uuidString
                    p.body = doc["body"] as? String ?? ""
                    p.commentCount = doc["commentCount"] as? Int ?? 0
                    p.likeCount = doc["likeCount"] as? Int ?? 0
                    p.name = doc["name"] as? String ?? ""
                    p.username = doc["username"] as? String ?? ""
                    p.userId = doc["userId"] as? String ?? ""
                    p.draft = doc["draft"] as? Bool ?? false
                
                post.append(p)
            }
            
            DispatchQueue.main.async {
                
                // Set all post data to local posts environment object
                self.posts = post
            }
        }
    }
    
    
    // MARK: Data Mutation Methods
    
    // Create new post
    func createPost(postBody: String?, draft: Bool) {

        // Check currentUser is valid
        guard Auth.auth().currentUser != nil else {
            print("User not authenticated")
            return
        }
        
        // Current user id
        let userId = Auth.auth().currentUser?.uid
        
        // Create document id for new post
        let postId = UUID().uuidString
        
        // Store post data in dict
        let postData: [String: Any] = [
            "userId": userId!,
            "name": UserService.shared.user.name,
            "username": UserService.shared.user.username,
            "body": postBody ?? "",
            "draft": draft
        ]
        
        // Create new post in db
        db.collection("post").document(postId).setData(postData) { error in
            
            if error != nil {
                print("Problem adding post to database")
                print(error!.localizedDescription)
            }
            else {
                print("Post created successfully")
            }
        }

        // Reference to user doc
        let userDoc = db.collection("users").document(userId!)
        
        // Create reference to new post in user doc
        userDoc.setData(["posts" : FieldValue.arrayUnion([postId])], merge: true) { error in

            if error != nil {
                print("Problem updating user post id in database")
                print(error!.localizedDescription)
            }
            else {
                print("User post data updated successfully")
            }
        }
    }
}
