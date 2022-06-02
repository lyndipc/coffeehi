//
//  UserService.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/2/22.
//

import Foundation

class UserService {
    
    var user = User()
    
    static var shared = UserService()
    
    private init() {
        
    }
}
