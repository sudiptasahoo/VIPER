//
//  ContactEditInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift
import Networking

enum FieldValidationError: String, Error, RawRepresentable, LocalizedError{
    case invalidEmail = "Please enter a valid Email Address"
    case invalidPhone = "Please enter a valid Phone no"
    case invalidFirstName = "Please enter a valid Firstname"
    case invalidLastName = "Please enter a valid Lastname"
    case emptyEmail = "Please enter your Email Address"
    case emptyPhone = "Please enter your Phone No"
    case emptyFirstname = "Please enter your Firstname"
    case emptyLastName = "Please enter your Lastname"
    
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}

// MARK:- Interaction Protocol
protocol ContactEditInteraction: ContactCRUDable {
    func validateAndUpdate(_ contact: Contact, mode: ContactEditMode) throws -> Observable<Contact>
}

class ContactEditInteractor: ContactEditInteraction{
    
    var networking: Networking
    private let disposeBag = DisposeBag()
    
    /// Init
    init(_ networking: Networking) {
        self.networking = networking
    }
    
    func validateAndUpdate(_ contact: Contact, mode: ContactEditMode) throws -> Observable<Contact> {
        
        guard let firstName = contact.firstName, !firstName.isEmpty else {throw FieldValidationError.emptyLastName}
        guard let lastName = contact.lastName, !lastName.isEmpty else {throw FieldValidationError.emptyLastName}
        guard let phoneNo = contact.phoneNumber, !phoneNo.isEmpty else {throw FieldValidationError.emptyPhone}
        guard let email = contact.email, !email.isEmpty else {throw FieldValidationError.emptyEmail}
        
        guard firstName.isValidName else {throw FieldValidationError.invalidFirstName}
        guard lastName.isValidName else {throw FieldValidationError.invalidLastName}
        guard phoneNo.isValidPhone else {throw FieldValidationError.invalidPhone}
        guard email.isValidEmail else {throw FieldValidationError.invalidEmail}
        
        switch mode {
        case .new:
            return add(contact)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance)
        case .update:
            return update(contact)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance)
        }
    }
    
}
