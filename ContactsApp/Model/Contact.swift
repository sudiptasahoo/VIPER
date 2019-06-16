//
//  Contact.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

struct Contact: Codable{
    
    let id: Int
    var firstName: String
    var lastName: String
    let profilePic: String?
    var favorite: Bool
    let url: String?
    
    var email: String?
    var phoneNumber: String?
    
    //Will have to write custom decoder
    //let createdAt: Date?
    //let updatedAt: Date?
    
}
