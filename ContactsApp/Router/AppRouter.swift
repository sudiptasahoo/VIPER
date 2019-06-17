//
//  AppRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

struct AppRouter{
    
    ///This is the singleton/parent UINavigationController of the app
    private(set) var navController: UINavigationController
    
    static let shared = AppRouter()
    
    private init(){
        navController = UINavigationController(rootViewController: ContactListModuleBuilder.createModule())
        navController.navigationBar.tintColor = .signature
    }
}
