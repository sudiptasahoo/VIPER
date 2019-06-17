//
//  ContactEditPresenter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

final class ContactEditPresenter: ContactEditPresentable {
    
    weak var viewInterface: ContactEditViewInterface?
    private let disposeBag = DisposeBag()
    private(set) var contact: Contact?
    var tempContact: Contact
    var mode: ContactEditMode = .new
    var inheritedTask: PublishSubject<Contact>?
    let interactor: ContactEditInteractable
    let router: ContactEditRoutable

    init(interactor: ContactEditInteractable,
         router: ContactEditRoutable, contact: Contact?, mode: ContactEditMode, inheritedTask: PublishSubject<Contact>) {
        self.interactor = interactor
        self.router = router
        self.contact = contact
        self.tempContact = contact ?? Contact()
        self.mode = mode
        self.inheritedTask = inheritedTask
    }
    
    // MARK: Logic
    var sections: Int {
        return DetailSection.allCases.count
    }
    
    func getNoOfRows(for section: Int) -> Int{
        
        guard let sectionType = DetailSection(rawValue: section) else { fatalError("Wrong section setup in ContactDetailPresenter")}
        
        switch sectionType {
        case .header: return 1
        case .metadata: return MetadataType.allCases.count
        }
    }
    
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType {
        
        guard let sectionType = DetailSection(rawValue: indexPath.section) else { fatalError("Wrong section setup in ContactDetailPresenter")}
        
        
        switch sectionType {
        case .header: return .profileImage
        case .metadata:
            
            guard let rowType = MetadataType(rawValue: indexPath.row) else { fatalError("Wrong rows setup in ContactDetailPresenter")}
            
            switch rowType{
            case .email: return .email
            case .firstName: return .firstName
            case .lastName: return .lastName
            case .phone: return .phone
            }
        }
    }
    
    func updateContact(contact: Contact) throws {
        
        try interactor.validateAndUpdate(contact, mode: mode)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (contact: Contact) in
                guard let self = self else {
                    return
                }
                self.contact = contact
                self.inheritedTask?.onNext(contact)
                self.tempContact = contact
                self.router.dismiss()
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.viewInterface?.showUpdate(error: error)
            })
            .disposed(by: disposeBag)
    }
}




