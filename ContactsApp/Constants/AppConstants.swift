//
//  AppConstants.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

// Contains all constants used across the app
struct AppConstants{
    
    ///Default constants of the app
    struct Defaults{
        
        static let TEXT_MESSAGE_BODY = "Sample text message"
        static let EMAIL_SUBJECT = "Sample email subject"
        static let EMAIL_BODY = "\nApp developed by Sudipta(dev@sudiptasahoo.in)"
        
        static let ERROR_TITLE = "Error"
        static let ERROR_MESSAGE = "Something went wrong"
        static let ERROR_OK_BUTTON_TEXT = "OK"
    }
    
    ///Networking related constants
    struct Networking {
        
        ///The GOJEK Contact Server Base URL
        static let BASE_URL = "https://gojek-contacts-app.herokuapp.com"
    }
}
