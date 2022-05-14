//
//  Post.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import Foundation

class Post: ObservableObject {

    var id: UUID?
    var username: String?
    var name: String?
    
    @Published var title: String?
    @Published var body: String?
    @Published var likeCount: Int?
    @Published var likesList: [String]?
    @Published var commentCount: Int?
    @Published var comments: [String]?
    
    
    init() {
        return
    }
}
