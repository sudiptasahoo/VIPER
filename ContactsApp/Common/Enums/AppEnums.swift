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

///Used for grouping sections in Details  screen
enum DetailSection: Int, CaseIterable, RawRepresentable{
    case header
    case metadata
}

///Used for grouping Details and Edit screen rows
enum MetadataDisplayType: Int, CaseIterable, RawRepresentable{
    case profileImage
    case firstName
    case lastName
    case phone
    case email
}

///Used to detect EDIT screen
enum ContactEditMode{
    
    ///New contact
    case new
    
    ///Update existing contact
    case update
}

///Used to group rows in the EDIT screen
enum MetadataType: Int, CaseIterable, RawRepresentable{
    
    case firstName
    case lastName
    case phone
    case email
}


///Form Validation errors
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


///To convert any kind of error into APpError
enum AppError: Error {
    
    ///Converts any error like NetworkError, etc into App Error
    case error(String)
}

//TODO: Convert network error and other error to this type
extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .error(let errorMsg):
            return errorMsg
        }
    }
}
