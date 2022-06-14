//
//  Post.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import Foundation

struct Post: Identifiable {
    var id: String = ""
    var userId: String = ""
    var username: String = ""
    var name: String = ""

    var title: String = ""
    var body: String = ""
    var draft: Bool = false
    var likeCount: Int = 0
    var likeList: [String] = [""]
    var commentCount: Int = 0
    var commentList: [String] = [""]
    var image: String = ""
    var location: [Location] = [Location]()
}

struct Location: Decodable {
    var latitude: Double?
    var longitude: Double?
}
