//
//  ContactListInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking
import RxSwift

// MARK:- Interaction Protocol
protocol ContactListInteraction {
    func loadContacts(endPoint: ContactEndPoint) -> Observable<[Contact]>
}

// MARK:- Interactor
class ContactListInteractor: ContactListInteraction {
    
    var networking: Networking!
    
    /// Init
    init(_ networking: Networking) {
        self.networking = networking
    }
    
    /// Get contacts from webservice
    /// On success: refresh contact list in list view
    /// On failure: show error view in list view
    func loadContacts(endPoint: ContactEndPoint) -> Observable<[Contact]> {

        return Observable.create { [weak networking] (observer) -> Disposable in
            
            let task = networking?.request(endPoint) { (result: Result<[Contact], Error>) in
                switch result {
                case .success(let contacts):
                    observer.onNext(contacts)
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
