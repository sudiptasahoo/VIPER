//
//  ContactListBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking

class ContactListModuleBuilder {
    lazy var interactor = ContactListInteractor(Networking.shared)
    lazy var router = ContactListRouter()
    lazy var presenter = ContactListPresenter(interactor: interactor, router: router)
    
    func makeContactListViewController() -> ContactListViewController {
        let listVc = ContactListViewController()
        listVc.presenter = presenter
        // Dependency Inversion
        presenter.contactListViewInterface = listVc
        
        return listVc
    }
}
