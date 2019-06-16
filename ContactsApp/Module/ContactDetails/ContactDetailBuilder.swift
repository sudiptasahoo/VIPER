//
//  ContactDetailBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit
import Networking

class ContactDetailModuleBuilder {
    lazy var interactor = ContactDetailInteractor(Networking.shared)
    lazy var router = ContactDetailRouter()
    var presenter: ContactDetailPresenter!
    
    func createModule(for contact: Contact) -> UIViewController {
        let view = ContactDetailViewController()
        presenter = ContactDetailPresenter(interactor: interactor, router: router, contact: contact)
        view.presenter = presenter
        presenter.viewInterface = view
        return view
    }
}
