//
//  User.swift
//  LendrApp
//
//  Created by Nestor Zepeda on 12/28/16.
//  Copyright © 2016 Lendr. All rights reserved.
//

import Foundation

class User {
    
    var id: String?;
    var firstName: String!;
    var lastName: String!;
    var email: String!;
    var profileImageUrl: String?
    var reviewScore: Int?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName;
        self.lastName = lastName;
    }
    
}
