//
//  NetworkError.swift
//  Networking
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    
    case failed(Error?)
    case outdated
    case badRequest
    case serverError
    case authenticationError
}

enum RequestError: Error, LocalizedError {
    
    case invalidRequest(String)
    case parametersNil
    case parameterEncodingFailed(ParameterEncodingFailureReason)
}

public enum ParameterEncodingFailureReason {
    case missingUrl
    case jsonEncoding(Error)
}

enum ResponseError: Error, LocalizedError {
    
    case unableToDecode(DecodingError)
    case noData(String)
}
