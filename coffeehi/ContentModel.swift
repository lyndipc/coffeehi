//
//  ContentModel.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/28/22.
//

import Foundation
import FirebaseFirestore

class ContentModel: ObservableObject {
    
    let db = FirebaseFirestore.Firestore.firestore()
    
    // List of posts
    @Published var posts = [Post]()
    
    init() {
        
        // Get recent posts
        getRecentPosts()
    }
    
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
}
