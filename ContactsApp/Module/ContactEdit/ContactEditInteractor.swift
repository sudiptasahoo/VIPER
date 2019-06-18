//
//  ContactEditInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

final class ContactEditInteractor: ContactEditInteractable{
    
    var networking: NetworkManageable
    private let disposeBag = DisposeBag()
    
    /// Init
    init(_ networking: NetworkManageable) {
        self.networking = networking
    }
    
    func validate(_ contact: Contact) throws {
        
        guard let firstName = contact.firstName, !firstName.isEmpty else {throw FieldValidationError.emptyFirstname}
        guard let lastName = contact.lastName, !lastName.isEmpty else {throw FieldValidationError.emptyLastName}
        guard let phoneNo = contact.phoneNumber, !phoneNo.isEmpty else {throw FieldValidationError.emptyPhone}
        guard let email = contact.email, !email.isEmpty else {throw FieldValidationError.emptyEmail}
        
        guard firstName.isValidName else {throw FieldValidationError.invalidFirstName}
        guard lastName.isValidName else {throw FieldValidationError.invalidLastName}
        guard phoneNo.isValidPhone else {throw FieldValidationError.invalidPhone}
        guard email.isValidEmail else {throw FieldValidationError.invalidEmail}
    }
    
    func update(_ contact: Contact, mode: ContactEditMode) -> Observable<Contact> {
        
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
