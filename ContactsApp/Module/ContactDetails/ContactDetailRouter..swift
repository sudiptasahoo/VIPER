//
//  ContactDetailRouter..swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ContactDetailRouting: class {
    var editModule: ContactEditModuleBuilder { get }
    
    func routeToEditScreen(with contact: Contact)
}

class ContactDetailRouter: ContactDetailRouting {
    
    var editModule: ContactEditModuleBuilder
    
    init(editModule: ContactEditModuleBuilder = ContactEditModuleBuilder()) {
        self.editModule = editModule
    }
    
    func routeToEditScreen(with contact: Contact) {
        let editVc = editModule.createModule(for: contact, mode: .update)
        let navVc = AppRouter.shared.navController
        navVc.present(editVc, animated: true, completion: nil)
    }
}
