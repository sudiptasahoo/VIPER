//
//  ContactEditProtocols.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 17/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

// Presenter -> View Interface
protocol ContactEditViewInterface: class {
    var presenter: ContactEditPresentable? { get set }
    func showUpdate(error: Error)
}

// View -> Presenter Interface
protocol ContactEditPresentable: class {
    var interactor: ContactEditInteractable { get }
    var router: ContactEditRoutable { get }
    var sections: Int { get }
    func getNoOfRows(for section: Int) -> Int
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType
    
    var contact: Contact? { get }
    
    ///For temporary storage of Edited Contact info
    var tempContact: Contact { get set }
    func updateContact(contact: Contact) throws
    
    ///Notifies about the tasks happening in this module
    var inheritedTask: PublishSubject<Contact>? { get set }
}

// MARK:- Interaction Protocol
protocol ContactEditInteractable: ContactCRUDable {
    func validateAndUpdate(_ contact: Contact, mode: ContactEditMode) throws -> Observable<Contact>
}

protocol ContactEditRoutable: class {
    var view: ContactEditViewController? { get set }
    func dismiss()
}
