//
//  ContactEditBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ContactEditModuleBuilder {
    
    class func createModule(for contact: Contact?, mode: ContactEditMode, inheritedTask: PublishSubject<Contact>) -> UIViewController {
        
        let interactor = ContactEditInteractor(NetworkManager.shared)
        let router = ContactEditRouter()
        let presenter = ContactEditPresenter(interactor: interactor, router: router, contact: contact, mode: mode, inheritedTask: inheritedTask)
        let view = ContactEditViewController()

        view.presenter = presenter
        
        //dependency inversion
        router.view = view
        presenter.viewInterface = view
        
        return view
    }
}
