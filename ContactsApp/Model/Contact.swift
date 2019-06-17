//
//  Contact.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

struct Contact: Codable{
    
    var id: Int
    var firstName: String?
    var lastName: String?
    var profilePic: String?
    var favorite: Bool
    var url: String?
    
    var email: String?
    var phoneNumber: String?
    
    var fullName: String?{
        
        if let fName = firstName, let lName = lastName{
            return "\(fName) \(lName)"
        }
        
        return firstName ?? lastName
    }
    
    init() {
        id = 0
        firstName = nil
        lastName = nil
        profilePic = nil
        favorite = false
        url = nil
        email = nil
        phoneNumber = nil
    }
    
    //Will have to write custom decoder
    //let createdAt: Date?
    //let updatedAt: Date?
}
