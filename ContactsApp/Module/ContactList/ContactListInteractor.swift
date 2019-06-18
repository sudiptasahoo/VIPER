//
//  ContactListInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift
import Networking

// MARK:- Interactor
final class ContactListInteractor: ContactListInteractable {
    
    var networking: NetworkManageable!
    
    // MARK:- Init
    init(_ networking: NetworkManageable) {
        self.networking = networking
    }
    
    func sortingPredicate(lhs: Character, rhs: Character) -> Bool {
        
        if lhs.isLetter && !rhs.isLetter {
            return true
        }
        if !lhs.isLetter && rhs.isLetter {
            return false
        }
        return lhs < rhs
    }
    
    private var predicate: (Contact) -> Character = {
        guard let c = $0.firstName?.uppercased().first else { fatalError() }
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numeric = "0123456789"
        if c.isLetter {
            return c
        } else if c.isNumber {
            return "#" as Character
        } else {
            return "?" as Character
        }
    }
    
    
    /** Get contacts from webservice using Networking framework
     On success: refresh contact list in list view
     On failure: show error view in list view
     */
    func loadContacts(from endPoint: EndPoint) -> Observable<Dictionary<Character, [Contact]>> {
        
        return Observable.create { [weak networking] (observer) -> Disposable in
            
            let task = networking?.request(endPoint) {[weak self] (result: Result<[Contact], Error>) in
                
                guard let self = self else {return}
                
                switch result {
                case .success(let contacts):
                    
                    let sortedContacts = contacts.sorted(by: { (contact1, contact2) -> Bool in
                        
                        if let fullName1 = contact1.fullName, let fullName2 = contact2.fullName{
                            return fullName1.lowercased() < fullName2.lowercased()
                        }
                        return false
                    })
                    
                    let groupedContact = Dictionary(grouping: sortedContacts, by: self.predicate)
                    
                    observer.onNext(groupedContact)
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
