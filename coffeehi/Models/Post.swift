//
//  Post.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import Foundation

class Post: Identifiable, ObservableObject {

    var postId: UUID?
    var userId: UUID?
    var username: String?
    var name: String?
    
    var title: String?
    var body: String?
    var likeCount: Int?
    var likesList: [String]?
    var commentCount: Int?
    var comments: [String]?
    var type: String?
    var image: String?
    var location: Location?
    var recipe: Recipe?
}

struct Recipe {
    
    var recipeId: UUID?
    var recipeTitle: String?
    var recipeIngredients: [String]?
    var recipeDirections: [String]?
}

struct Location: Decodable {
    
    var latitude: Double?
    var longitude: Double?
}
