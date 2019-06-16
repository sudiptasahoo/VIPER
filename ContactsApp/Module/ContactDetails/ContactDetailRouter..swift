//
//  ContactDetailRouter..swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ContactDetailRouting: class {
}

class ContactDetailRouter: ContactDetailRouting {
    private let container: ContactDetailModuleBuilder
    init(container: ContactDetailModuleBuilder = ContactDetailModuleBuilder()) {
        self.container = container
    }
}
