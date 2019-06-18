//
//  EndPoint.swift
//  NetworkingTests
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
@testable import Networking

enum TestEndPoint{
    
    case validEndPoint
    case invalidEndPoint
}

extension TestEndPoint: EndPoint{
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
    
   
    var path: String {
        switch self{
        case .validEndPoint: return "/contacts.json"
        case .invalidEndPoint: return "/invalid"
        }
    }
    
    var task: HTTPTask {
        switch self{
        case .validEndPoint: return .requestPlain
        case .invalidEndPoint: return .requestPlain
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .validEndPoint: return .GET
        case .invalidEndPoint: return .GET
        }
    }
}
