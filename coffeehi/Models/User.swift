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
    var followersList: [String: Any] = [:]
    var followersCount: Int {
        followersList.count
    }
    var followingList: [Following] = [Following]()
}

struct Following: Identifiable {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var pfp: String = ""
}

struct Followers: Identifiable {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var pfp: String = ""
}
