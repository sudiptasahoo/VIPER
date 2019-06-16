//
//  ContactListPresenter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

// MARK:- Contact List Presentation Protocol
// View -> Presenter Interface
protocol ContactListPresentation: class {
    
    ///Gives no of sections for UITableView datasource
    var sections: Int { get }
    
    ///Gives no of rows for UITableView datasource
    func getRows(at section: Int) -> Int
    
    ///Loads Contacts from API
    func loadContacts()
    
    ///Opens the Contact Details fpr contact at indexPath
    func selectContact(at indexPath: IndexPath)
    
    ///Returns Section name for Section Header
    func getSectionName(at index: Int) -> String?
    
    ///Returns all the possible section names in an array at once
    func getSectionNames() -> [String]?
    
    ///Returns Contact at indexPath
    func getContact(at indexPath: IndexPath) -> Contact?
    
    ///Routes to Edit Screen with editMode = .new
    func routeToEditScreen()
}

// MARK:- Presenter -> View Interface
protocol ContactListViewInterface: class {
    func refreshContactList()
    func showLoadingError(errorMessage: String)
}

// MARK:- Presenter
class ContactListPresenter: ContactListPresentation {
    
    // MARK: Init
    private var interactor: ContactListInteraction
    private let router: ContactListRouting
    weak var contactListViewInterface: ContactListViewInterface?
    let disposeBag = DisposeBag()
    
    init(interactor: ContactListInteraction, router: ContactListRouting){
        self.interactor = interactor
        self.router = router
    }
    
    private(set) var contactsModel : Dictionary<Character, [Contact]>?
    private(set) var contacts: [Contact]? {
        didSet {
            guard let contacts = contacts, !contacts.isEmpty else {
                contactListViewInterface?.showLoadingError(errorMessage: "No contact Loaded")
                return
            }
            
            
            let sortedContacts = contacts.sorted(by: { (contact1, contact2) -> Bool in
                
                if let fName1 = contact1.firstName, let fName2 = contact2.firstName{
                    return fName1.lowercased() < fName2.lowercased()
                }
                return false
            })
            
            contactsModel = Dictionary(grouping: sortedContacts, by: predicate)
            
            contactListViewInterface?.refreshContactList()
        }
    }
    
    private func sortedLettersFirst(lhs: Character, rhs: Character) -> Bool {
        
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
    
    // MARK: Logic
    
    private func getContacts(at section: Int) -> [Contact]?{
        if let key = getSectionName(at: section)?.first {
            return contactsModel?[key]
        }
        return nil
    }
    var sections: Int {
        return contactsModel?.keys.count ?? 0
    }
    
    func getRows(at section: Int) -> Int{
        return getContacts(at: section)?.count ?? 0
    }
    
    func getSectionName(at index: Int) -> String?{
        if let char = contactsModel?.keys.sorted(by: sortedLettersFirst)[index]{
            return String(char)
        }
        return nil
    }
    
    func getSectionNames() -> [String]?{
        return contactsModel?.keys.sorted(by: sortedLettersFirst).compactMap{ String($0) }
    }
    
    func getContact(at indexPath: IndexPath) -> Contact?{
        if let contacts = getContacts(at: indexPath.section){
            return contacts[indexPath.row]
        }
        return nil
    }
    
    func loadContacts() {
        interactor.loadContacts(endPoint: .getContacts)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (contacts: [Contact]) in
                guard let self = self else {
                    return
                }
                self.contacts = contacts
                self.contactListViewInterface?.refreshContactList()
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.contactListViewInterface?.showLoadingError(errorMessage: "Some Error occured")
            })
            .disposed(by: disposeBag)
        
    }
    
    func selectContact(at indexPath: IndexPath){
        guard let contact = getContact(at: indexPath) else {return}
        router.presentContactDetailView(with: contact)
    }
    
    func routeToEditScreen() {
        router.routeToEditScreen()
    }
    
}
