//
//  User.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/2/22.
//

import Foundation

struct User: Identifiable {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var bio: String = ""
    var pfp: String = ""
    var posts: [String] = []
    var postsCount: Int {
        posts.count
    }
    var followers: [Any] = []
    var followersCount: Int {
        followers.count
    }
    var following: [Any] = []
    var followingCount: Int {
        following.count
    }
}
