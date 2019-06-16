//
//  String+Validations.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidName: Bool {
//        let regEx = "(?<! )[-a-zA-Z' ]{2,26}"
//        let nameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
//        return nameTest.evaluate(with: self)
        return true
    }
}

extension Character{
    
    func groupCharacter() -> Character{
        if self.isLetter{
            return self
        } else{
            return "#" as Character
        }
    }
}
