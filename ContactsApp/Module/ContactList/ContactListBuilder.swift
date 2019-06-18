//
//  ContactListBuilder.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

final class ContactListModuleBuilder {
    
    class func createModule() -> ContactListViewController {
        
        let interactor = ContactListInteractor(NetworkManager.shared)
        let router = ContactListRouter()
        let presenter = ContactListPresenter(interactor: interactor, router: router)
        let listVc = ContactListViewController()
        
        listVc.presenter = presenter
        
        // Dependency Inversion
        presenter.contactListViewInterface = listVc
        
        return listVc
    }
}
