//
//  ContactDetailProtocols.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 17/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

// Presenter -> View Interface
protocol ContactDetailViewInterface: class {
    var presenter: ContactDetailPresentable? { get set }
    func showContactFetchError()
    func showContactExtraDetail(contact: Contact)
    func showContactDetail(contact: Contact)
}

// View -> Presenter Interface
protocol ContactDetailPresentable: class {
    var interactor: ContactDetailInteractable { get }
    var router: ContactDetailRoutable { get }
    var sections: Int { get }
    func prepareToShowContactDetail()
    func getNoOfRows(for section: Int) -> Int
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType
    
    func toggleFavorite()
    
    var contact: Contact! { get }
    func routeToEditScreen()
    
    ///Oberves Contact update tasks happening elsewhere
    var updateTask: PublishSubject<Contact> { get set }
    
    ///Notifies about the tasks happening in this module
    var inheritedTask: PublishSubject<Contact>? { get set }
}


// MARK:- Interaction Protocol
protocol ContactDetailInteractable: ContactCRUDable {
    
}

protocol ContactDetailRoutable: class {
    
    func routeToEditScreen(with contact: Contact, inheritedTask: PublishSubject<Contact>)
}
