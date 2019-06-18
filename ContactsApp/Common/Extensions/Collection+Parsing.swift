//
//  Collection+Parsing.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ErrorParsable{
    
    ///Parses the error message and returns
    func errorMessage() -> String?
}


extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject{
    
    func gojekErrorMessage() -> String? {
        
        if let dict = (self as AnyObject) as? Dictionary<String, AnyObject> {
            if let value = dict["errors"] as? String{
                return value
            }
            
            if let value = dict["errors"] as? Array<String>{
                return value.reduce("", { (result, str) -> String in
                    return "\(result)\n\(str)"
                })
            }
        }
        
        return nil
    }
}

internal extension ErrorParsable where Self: ExpressibleByDictionaryLiteral, Self.Key == String, Self.Value == AnyObject {
    
    func errorMessage() -> String? {
        
        if let dict = (self as AnyObject) as? Dictionary<String, AnyObject> {
            if let value = dict["errors"] as? String{
                return value
            }
            
            if let value = dict["errors"] as? Array<String>{
                return value.reduce("", { (result, str) -> String in
                    return "\(result)\n\(str)"
                })
            }
        }
        
        return nil
    }
    
}
