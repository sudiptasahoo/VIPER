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
    
    ///Some err occurred while fetching data from API
    func showContactFetchError()
    
    ///Refresh the required part of the UI only and not the whole UI
    func showContactExtraDetail(contact: Contact)
    
    ///Refresh the whole UI with the new contact object
    func showContactDetail(contact: Contact)
}

// View -> Presenter Interface
protocol ContactDetailPresentable: class {
    var interactor: ContactDetailInteractable { get }
    var router: ContactDetailRoutable { get }
    var sections: Int { get }
    var contact: Contact! { get }
    
    ///Fetches Contact details from the API
    func prepareToShowContactDetail()
    
    /**
     Returns no of rows for a section
     - parameter section: The current section index
     */
    func getNoOfRows(for section: Int) -> Int
    
    ///Returns the display type
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType
    
    ///Toggles the stae of favourite from the backened
    func toggleFavorite()
    
    ///Routes to the EDIT Contact screen with the current Contact object
    func routeToEditScreen()
    
    ///Oberves Contact update tasks happening elsewhere
    var updateTask: PublishSubject<Contact> { get set }
    
    ///Notifies about the tasks happening in this module
    var inheritedTask: PublishSubject<Contact>? { get set }
}


// MARK:- Presenter -> Interactor
protocol ContactDetailInteractable: ContactCRUDable {
    
}

// MARK:- Presenter -> Router
protocol ContactDetailRoutable: class {
    
    ///Opens to the Details screen
    func routeToEditScreen(with contact: Contact, inheritedTask: PublishSubject<Contact>)
}
