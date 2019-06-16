//
//  ContactEditBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit
import Networking

class ContactEditModuleBuilder {
    lazy var interactor = ContactEditInteractor(Networking.shared)
    lazy var router = ContactEditRouter()
    var presenter: ContactEditPresenter!
    
    func createModule(for contact: Contact?, mode: ContactEditMode) -> UIViewController {
        let view = ContactEditViewController()
        presenter = ContactEditPresenter(interactor: interactor, router: router, contact: contact, mode: mode)
        view.presenter = presenter
        //dependency inversion
        router.view = view
        presenter.viewInterface = view
        return view
    }
}
