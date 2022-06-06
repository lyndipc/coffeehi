//
//  UserService.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/2/22.
//

import Foundation

class UserService {
    
    var user = User()
    var post = [Post]()
    
    static var shared = UserService()
    
    private init() {
        
    }
}
