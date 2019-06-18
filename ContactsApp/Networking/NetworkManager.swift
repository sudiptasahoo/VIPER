//
//  NetworkManager.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking

protocol NetworkManageable: class{
    @discardableResult
    func request<T: Decodable>(_ endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask?
}

final class NetworkManager: NetworkManageable{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(_ endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {
        return Networking.shared.request(endPoint, completion: completion)
    }
}

internal extension EndPoint{
    
    var baseURL: URL {
        guard let url = URL(string: AppConstants.Networking.BASE_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
}
