//
//  ListMockPresenter.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
@testable import ContactsApp
import RxSwift
import Networking


class ListMockPresenter: ContactListPresentable{
    
    weak var contactListViewInterface: ContactListViewInterface?
    
    var interactor: ContactListInteractable
    var updateTask: PublishSubject<Contact>
    
    init(interactor: ContactListInteractable) {
        self.interactor = interactor
        updateTask =  PublishSubject<Contact>()
    }
    
    var isSuccess = false
    var isError = false
    var closure: (() -> Void)!
    var endPoint: ContactMockEndPoint!
    var contactModel: Dictionary<Character, [Contact]>?
    
    var sections: Int = 0
    
    func getRows(at section: Int) -> Int {
        return 0
    }
    
    func loadContacts() {
        interactor.loadContacts(from: endPoint)
            .subscribe(onNext: { (result : Dictionary<Character, [Contact]>) in
                
                self.isSuccess = true
                self.isError = false
                self.contactModel = result
                self.closure()
            }, onError: { (error) in
                
                self.isSuccess = false
                self.isError = true
                self.closure()
            })
            .disposed(by: DisposeBag())
    }
    
    func selectContact(at indexPath: IndexPath) {
        
    }
    
    func getSectionName(at index: Int) -> String? {
        return nil
    }
    
    func getSectionNames() -> [String]? {
        return [""]
    }
    
    func getContact(at indexPath: IndexPath) -> Contact? {
        return Contact()
    }
    
    func routeToEditScreen() {
        
    }
    
}
