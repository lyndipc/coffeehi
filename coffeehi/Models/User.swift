//
//  User.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import Foundation

class User: Decodable, Identifiable, ObservableObject {
    
    var id: UUID?
    var name: String?
    var username: String?
    var password: String?
    var email: String?
    
    init() {
        return
    }
}
