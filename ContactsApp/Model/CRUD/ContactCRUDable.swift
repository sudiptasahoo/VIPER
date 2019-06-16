//
//  ContactCRUDable.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift
import Networking

protocol ContactCRUDable{
    var networking: Networking { get }
    func update(_ contact: Contact) -> Observable<Contact>
    func add(_ contact: Contact) -> Observable<Contact>
}

extension ContactCRUDable{
    
    func update(_ contact: Contact) -> Observable<Contact> {
        
        return Observable.create { [weak networking] (observer) -> Disposable in
            let task = networking?.request(ContactEndPoint.updateContact(contact)) { (result: Result<Contact, Error>) in
                switch result {
                case .success(let contact):
                    observer.onNext(contact)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    func add(_ contact: Contact) -> Observable<Contact> {
        
        return Observable.create { [weak networking] (observer) -> Disposable in
            let task = networking?.request(ContactEndPoint.addContact(contact)) { (result: Result<Contact, Error>) in
                switch result {
                case .success(let contact):
                    observer.onNext(contact)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
