//
//  AppEnums.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 17/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

//It says about the state of screen
enum PageState{
    
    ///Screen is loading data
    case loading
    
    ///Some error occured while fetching data. Error UI should be shown on the screen
    case error
    
    ///All is well
    case normal
}

enum DetailSection: Int, CaseIterable, RawRepresentable{
    case header
    case metadata
}

enum MetadataDisplayType: Int, CaseIterable, RawRepresentable{
    case profileImage
    case firstName
    case lastName
    case phone
    case email
}

enum ContactEditMode{
    case new
    case update
}

enum MetadataType: Int, CaseIterable, RawRepresentable{
    
    case firstName
    case lastName
    case phone
    case email
}

enum FieldValidationError: String, Error, RawRepresentable, LocalizedError{
    case invalidEmail = "Please enter a valid Email Address"
    case invalidPhone = "Please enter a valid Phone no"
    case invalidFirstName = "Please enter a valid Firstname"
    case invalidLastName = "Please enter a valid Lastname"
    case emptyEmail = "Please enter your Email Address"
    case emptyPhone = "Please enter your Phone No"
    case emptyFirstname = "Please enter your Firstname"
    case emptyLastName = "Please enter your Lastname"
    
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}


enum AppError: Error {
    
    ///Converts any error like NetworkError, etc into App Error
    case error(String)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .error(let errorMsg):
            return errorMsg
        }
    }
}
