//
//  ContactDetailRouter..swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

final class ContactDetailRouter: ContactDetailRoutable {
    
    func routeToEditScreen(with contact: Contact, inheritedTask: PublishSubject<Contact>) {
        let editVc = ContactEditModuleBuilder.createModule(for: contact, mode: .update, inheritedTask: inheritedTask)
        let navVc = AppRouter.shared.navController
        navVc.present(editVc, animated: true, completion: nil)
    }
}
