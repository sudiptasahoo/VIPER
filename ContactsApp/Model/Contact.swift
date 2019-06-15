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
    let firstName: String?
    let lastName: String?
    let profilePic: String?
    var favorite: Bool
    let url: String
}
