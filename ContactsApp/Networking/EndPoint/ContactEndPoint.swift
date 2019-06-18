//
//  ContactEndPoint.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking

enum ContactEndPoint {
    
    ///Fetches [Contacts]
    case getContacts
    
    ///Fetches a Contact for id
    case getContact(Int)
    
    ///Adds a new Contact
    case addContact(Contact)
    
    ///Updates an existing Contact
    case updateContact(Contact)
}

extension ContactEndPoint: EndPoint {
    
    var path: String {
        switch self{
            
        case .getContacts: return "/contacts.json"
            
        case .getContact(let contactId): return "/contacts/\(contactId).json"
            
        case .addContact: return "/contacts.json"
            
        case .updateContact(let contact): return "/contacts/\(contact.id).json"
            
        }
    }
    
    var task: HTTPTask {
        switch self{
        case .getContacts: return .requestPlain
        case .getContact: return .requestPlain
        case .addContact(let contact): return .requestJSONEncodable(contact)
        case .updateContact(let contact): return .requestJSONEncodable(contact)
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .getContacts: return .GET
        case .getContact: return .GET
        case .addContact: return .POST
        case .updateContact: return .PUT
        }
    }
    
}
