//
//  NetworkManager.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking

extension EndPoint{
    
    var baseURL: URL {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
}
