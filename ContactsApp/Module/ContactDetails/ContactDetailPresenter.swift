//
//  ContactDetailPresenter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

class ContactDetailPresenter: ContactDetailPresentable {
    
    var interactor: ContactDetailInteractable
    var router: ContactDetailRoutable
    weak var viewInterface: ContactDetailViewInterface?
    private let disposeBag = DisposeBag()
    private(set) var contact: Contact!
    var updateTask = PublishSubject<Contact>()
    weak var inheritedTask : PublishSubject<Contact>?
    
    init(interactor: ContactDetailInteractable,
         router: ContactDetailRoutable, contact: Contact, inheritedTask: PublishSubject<Contact>) {
        self.interactor = interactor
        self.router = router
        self.contact = contact
        self.inheritedTask = inheritedTask
        
        updateTask
            .subscribe(onNext: {[weak self] (contact) in
                self?.prepareToShowContactDetail()
                inheritedTask.onNext(contact)
            })
            .disposed(by: disposeBag)
        
    }
    
    deinit {
        print("deinit Detail presenter")
    }
    
    // MARK: Logic
    var sections: Int {
        return DetailSection.allCases.count
    }
    
    func prepareToShowContactDetail() {
        
        interactor.get(for: contact.id)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (contact: Contact) in
                guard let self = self else {
                    return
                }
                
                let oldContact = self.contact ?? Contact()
                self.contact = contact
                
                if oldContact.favorite == contact.favorite &&
                    oldContact.firstName == contact.firstName &&
                    oldContact.lastName == contact.lastName &&
                    oldContact.profilePic == contact.profilePic{
                    self.viewInterface?.showContactExtraDetail(contact: contact)
                } else{
                    self.viewInterface?.showContactDetail(contact: contact)
                }
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.viewInterface?.showContactFetchError()
            })
            .disposed(by: disposeBag)
    }
    
    func getNoOfRows(for section: Int) -> Int{
        
        guard let sectionType = DetailSection(rawValue: section) else { fatalError("Wrong section setup in ContactDetailPresenter")}
        
        switch sectionType {
        case .header: return 1
        case .metadata:
            var rows = 0
            
            if let ph = contact.phoneNumber, !ph.isEmpty{
                rows += 1
            }
            
            if let email = contact.email, !email.isEmpty{
                rows += 1
            }
            
            return rows
        }
    }
    
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType {
        
        guard let sectionType = DetailSection(rawValue: indexPath.section) else { fatalError("Wrong section setup in ContactDetailPresenter")}
        
        
        switch sectionType {
        case .header: return .profileImage
        case .metadata:
            
            if indexPath.row == 0{
                return .phone
            } else if indexPath.row == 1{
                return .email
            } else{
                fatalError("Invalid rows setup in getNoOfRows(for section: Int) -> Int")
            }
        }
    }
    
    func toggleFavorite() {
        
        contact.favorite = !contact.favorite
        
        interactor.update(contact)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (contact: Contact) in
                guard let self = self else {
                    return
                }
                self.contact = contact
                self.inheritedTask?.onNext(contact)
                self.viewInterface?.showContactDetail(contact: contact)
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.viewInterface?.showContactFetchError()
            })
            .disposed(by: disposeBag)
    }
    
    func routeToEditScreen() {
        router.routeToEditScreen(with: contact, inheritedTask: updateTask)
    }
}
