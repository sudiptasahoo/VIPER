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
    
    ///Some error ocurred while updating. Validation Error or Network Error
    func showUpdate(error: Error)
}

// View -> Presenter Interface
protocol ContactEditPresentable: class {
    var interactor: ContactEditInteractable { get }
    var router: ContactEditRoutable { get }
    var sections: Int { get }
    var contact: Contact? { get }
    
    ///Returns rows count for tableview
    func getNoOfRows(for section: Int) -> Int
    
    ///Returns display type for rendering UITableViewCell
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType
    
    
    ///For temporary storage of Edited Contact info
    var tempContact: Contact { get set }
    
    ///Updates the contact object by calling API
    func updateContact(contact: Contact) throws
    
    ///Notifies about the tasks happening in this module
    var inheritedTask: PublishSubject<Contact>? { get set }
}

// MARK:- Interaction Protocol
protocol ContactEditInteractable: ContactCRUDable {
    
    /**Validates the contact fields
     - throws VALIDATION Error
     */
    func validate(_ contact: Contact) throws
    
    /**Update or Add contact according to the mode
     - parameter mode: Edit mode new or update
    */
    func update(_ contact: Contact, mode: ContactEditMode) -> Observable<Contact>
}

protocol ContactEditRoutable: class {
    var view: ContactEditViewController? { get set }
    func dismiss()
}
