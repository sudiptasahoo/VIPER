//
//  EndPointMock.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
@testable import ContactsApp
import Networking

enum ContactMockEndPoint{
    
    case contactsSuccess
    case contactsFailure
    
    case contactSuccess(Int)
    case contactFailure(Int)
    
    case updateContactSuccess(Contact)
    case updateContactFailure(Contact)
}

extension ContactMockEndPoint: EndPoint{
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
    
    
    var path: String {
        return ""
    }
    
    var task: HTTPTask {
        return .requestPlain
    }
    
    var method: HTTPMethod {
        return .GET
    }
}
