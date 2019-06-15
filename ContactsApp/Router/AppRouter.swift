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
    
    private(set) var navController: UINavigationController
    
    static let shared = AppRouter()
    
    private init(){
        navController = UINavigationController(rootViewController: ContactListingViewController())
        navController.navigationBar.tintColor = .signature
    }
    
    func routeToContactDetails(for contact: Contact){
        
        let contactDetailsVc = ContactDetailViewController(contact)
        self.navController.pushViewController(contactDetailsVc, animated: true)
    }
}
