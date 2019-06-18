//
//  ContactListRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

final class ContactListRouter: ContactListRoutable {
    
    func presentContactDetailView(with contact: Contact, inheritedTask: PublishSubject<Contact>) {
        let detailVC = ContactDetailModuleBuilder.createModule(for: contact, inheritedTask: inheritedTask)
        let navVc = AppRouter.shared.navController
        navVc.pushViewController(detailVC, animated: true)
    }
    
    func routeToEditScreen(inheritedTask: PublishSubject<Contact>) {
        let editVc = ContactEditModuleBuilder.createModule(for: nil, mode: .new, inheritedTask: inheritedTask)
        let navVc = AppRouter.shared.navController
        navVc.present(editVc, animated: true, completion: nil)
    }
}

