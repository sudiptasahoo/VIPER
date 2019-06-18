//
//  NetworkManagerMock.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
@testable import ContactsApp
import Networking

class NetworkManagerMock: NetworkManageable{
    
    static let shared = NetworkManagerMock()
    
    func request<T>(_ endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? where T : Decodable {
        
        let error = NSError() as Error
        
        if let ep = endPoint as? ContactMockEndPoint{
            
            switch ep{
            case .contactFailure:
                completion(.failure(error))
                
            case .contactsSuccess:
                completion(.success(MockContact.shared.contacts as! T))
                
            case .contactsFailure:
                completion(.failure(error))
                
            case .contactSuccess(_):
                completion(.success(MockContact.shared.contact as! T))
                
            case .updateContactSuccess(_):
                completion(.success(MockContact.shared.contact as! T))
                
            case .updateContactFailure(_):
                completion(.failure(error))

            }
        }
        
        if let ep = endPoint as? ContactEndPoint{
            
            switch ep{
            case .getContacts: completion(.success(MockContact.shared.contacts as! T))
            case .addContact, .updateContact, .getContact: completion(.success(MockContact.shared.contact as! T))
            }
        }

        
        return nil
    }
}
