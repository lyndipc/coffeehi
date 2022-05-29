//
//  User.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import Foundation

struct User: Identifiable {
    
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var password: String = ""
    var email: String = ""
    var posts: [Post] = [Post]()
}
