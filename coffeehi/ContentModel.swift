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
    @Published var posts: [Post] = [Post]()
    
    // Post body
    private var postBody: String?
    
    init() {
    }
    
    // MARK: Authentication Methods
    
    // Check if user is logged in
    func checkLogin() {
        
        // Check if there's a current user
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // Check if user meta data has been fetched
        if UserService.shared.user.name == "" {
            
            self.getUserData()
        }
    }
    
    
    // MARK: Data Retrieval Methods
    
    // Get user data
    func getUserData() {
        
        // Fetch data from Firestore
        if let userId = Auth.auth().currentUser?.uid {
            
            // Create reference to user document
            let users = db.collection("users").document(userId)
            
            // Retrieve user document from firestore
            users.getDocument { docSnapshot, error in
                
                // Create user instance
                var user = [User]()
                let u = User()
                
                // If document snapshot contains data & no errors are returned
                guard error == nil, docSnapshot != nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Extract fields from document snapshot and store in UserService
                u.id = docSnapshot?.get("id") as? String ?? ""
                u.name = docSnapshot?.get("name") as? String ?? ""
                u.username = docSnapshot?.get("username") as? String ?? ""
                
                // Extract map from document snapshot
                let profileMap = docSnapshot?.get("profile") as! [String: Any]
                
                // Store profile data in UserService
                u.bio = profileMap["bio"] as? String ?? ""
                u.pfp = profileMap["pfp"] as? String ?? ""
                
                user.append(u)
                
                DispatchQueue.main.async {
                    
                    // Store user data locally
                    UserService.shared.user = u
                    
                    self.user = user
                }
            }
            
            // Update user's feed
            getRecentPosts()
        }
        else {
            
            return
        }
    }
    
    // TODO: Add listener to update user's feed as soon as a new post is successfully created, mutated, etc.
    
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
    func createPost(postBody: String?) {

        // Check that user is authenticated
        guard Auth.auth().currentUser != nil else {
            print("User not authenticated")
            return
        }
        
        // Current user id
        let userId = Auth.auth().currentUser?.uid
        
        // Store post data in dict
        let postData: [String: Any] = [
            "userId": userId!,
            "name": UserService.shared.user.name,
            "username": UserService.shared.user.username,
            "body": postBody ?? ""
        ]
        
        // Firestore post collection path
        let newPost = db.collection("post")
        
        // Add new post data to firestore
        newPost.addDocument(data: postData) { error in
            
            if error != nil {
                print("Problem adding post to database")
                print(error!.localizedDescription)
            }
            else {
                print("Post created successfully")
            }
        }
    }
    
    // TODO: Create save draft post method
    
    // Update user's profile
    func updateProfile(bio: String?, pfp: String?) {
        
        // Check that there is a valid user
        if let userId = Auth.auth().currentUser?.uid {
            
            // Create reference to user instance
            let user = UserService.shared.user
            
            // Save user's profile locally
            user.bio = bio ?? ""
            user.pfp = pfp ?? ""
            
            // Update profile info in firestore
            let users = db.collection("users")
            users.document(userId).updateData(["profile": [
                "bio": bio ?? "",
                "pfp": pfp ?? ""
            ]])
        }
        
        // TODO: Update UI after profile has been changed
    }
}
