//
//  ContactDetailInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking
import RxSwift


// MARK:- Interaction Protocol
protocol ContactDetailInteraction: ContactCRUDable {
    func loadContactDetails(endPoint: ContactEndPoint) -> Observable<Contact>
}

class ContactDetailInteractor: ContactDetailInteraction {
        
    var networking: Networking
    
    /// Init
    init(_ networking: Networking) {
        self.networking = networking
    }
    
    /// Get contact details from webservice
    /// On success: refresh contact detail in vc
    /// On failure: show error view in detail vc
    func loadContactDetails(endPoint: ContactEndPoint) -> Observable<Contact> {

        return Observable.create { [weak networking] (observer) -> Disposable in
            let task = networking?.request(endPoint) { (result: Result<Contact, Error>) in
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
