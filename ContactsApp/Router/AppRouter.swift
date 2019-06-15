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
        navController.pushViewController(contactDetailsVc, animated: true)
    }
    
    func routeToEditContactDetails(for contact: Contact?, mode: ContactEditMode){
        let contactDetailsVc = ContactEditViewController(contact, mode: mode)
        navController.present(contactDetailsVc, animated: true, completion: nil)
    }
}
