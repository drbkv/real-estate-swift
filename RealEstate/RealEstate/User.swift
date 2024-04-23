//
//  User.swift
//  RealEstate
//
//  Created by Ramzan on 19.04.2024.
//

import Foundation
class User {
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
