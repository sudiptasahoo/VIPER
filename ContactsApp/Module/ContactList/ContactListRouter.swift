//
//  ContactListRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ContactListRouting: class {
    var container: ContactDetailModuleBuilder { get set }
    func presentContactDetailView(with contact: Contact)
}

class ContactListRouter: ContactListRouting {
    
    var container = ContactDetailModuleBuilder()
    let listContainer = ContactListModuleBuilder()
    
    func presentContactDetailView(with contact: Contact) {
        let detailVC = container.createModule(for: contact)
        let navVc = AppRouter.shared.navController
        navVc.pushViewController(detailVC, animated: true)
    }
}

