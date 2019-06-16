//
//  ContactListRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ContactListRouting: class {
    var detailModule: ContactDetailModuleBuilder { get }
    var editModule: ContactEditModuleBuilder { get }

    func presentContactDetailView(with contact: Contact)
    func routeToEditScreen()
}

class ContactListRouter: ContactListRouting {
    
    var detailModule = ContactDetailModuleBuilder()
    var editModule = ContactEditModuleBuilder()
    
    func presentContactDetailView(with contact: Contact) {
        let detailVC = detailModule.createModule(for: contact)
        let navVc = AppRouter.shared.navController
        navVc.pushViewController(detailVC, animated: true)
    }
    
    func routeToEditScreen() {
        let editVc = editModule.createModule(for: nil, mode: .new)
        let navVc = AppRouter.shared.navController
        navVc.present(editVc, animated: true, completion: nil)
    }
}

