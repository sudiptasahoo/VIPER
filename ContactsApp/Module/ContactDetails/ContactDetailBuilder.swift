//
//  ContactDetailBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ContactDetailModuleBuilder {
    
    class func createModule(for contact: Contact, inheritedTask: PublishSubject<Contact>) -> UIViewController {
        
        let interactor = ContactDetailInteractor(NetworkManager.shared)
        let router = ContactDetailRouter()
        let presenter = ContactDetailPresenter(interactor: interactor, router: router, contact: contact, inheritedTask: inheritedTask)
        let vc = ContactDetailViewController()
        vc.presenter = presenter
        
        // Dependency Inversion
        presenter.viewInterface = vc
        
        return vc
    }
}
