//
//  ContactListPresenter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

final class ContactListPresenter: ContactListPresentable {
    
    // MARK: Init
    private(set) var groupedContact : Dictionary<Character, [Contact]>?
    private let interactor: ContactListInteractable
    private let router: ContactListRoutable
    weak var contactListViewInterface: ContactListViewInterface?
    let updateTask = PublishSubject<Contact>()
    let disposeBag = DisposeBag()
    
    init(interactor: ContactListInteractable, router: ContactListRoutable){
        self.interactor = interactor
        self.router = router
        
        updateTask
            .subscribe(onNext: {[weak self] (contact) in
               self?.loadContacts()
            })
        .disposed(by: disposeBag)
    }
    
    // MARK: Logic
    
    private func getContacts(at section: Int) -> [Contact]?{
        if let key = getSectionName(at: section)?.first {
            return groupedContact?[key]
        }
        return nil
    }
    var sections: Int {
        return groupedContact?.keys.count ?? 0
    }
    
    func getRows(at section: Int) -> Int{
        return getContacts(at: section)?.count ?? 0
    }
    
    func getSectionName(at index: Int) -> String?{
        if let char = groupedContact?.keys.sorted(by: interactor.sortingPredicate)[safe: index]{
            return String(char)
        }
        return nil
    }
    
    func getSectionNames() -> [String]?{
        return groupedContact?.keys.sorted(by: interactor.sortingPredicate).compactMap{ String($0) }
    }
    
    func getContact(at indexPath: IndexPath) -> Contact?{
        if let contacts = getContacts(at: indexPath.section){
            return contacts[safe: indexPath.row]
        }
        return nil
    }
    
    func loadContacts() {
        interactor.loadContacts(from: .getContacts)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (groupedContact: Dictionary<Character, [Contact]>) in
                guard let self = self else {
                    return
                }
                self.groupedContact = groupedContact
                self.contactListViewInterface?.refreshContactList()
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.contactListViewInterface?.showLoadingError(with: "Some Error occured")
            })
            .disposed(by: disposeBag)
    }
    
    func selectContact(at indexPath: IndexPath){
        guard let contact = getContact(at: indexPath) else {return}
        router.presentContactDetailView(with: contact, inheritedTask: updateTask)
    }
    
    func routeToEditScreen() {
        router.routeToEditScreen(inheritedTask: updateTask)
    }
    
}
