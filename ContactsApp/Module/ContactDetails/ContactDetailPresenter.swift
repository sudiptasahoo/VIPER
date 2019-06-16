//
//  ContactDetailPresenter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

enum DetailSection: Int, CaseIterable, RawRepresentable{
    case header
    case metadata
}

enum MetadataDisplayType: Int, CaseIterable, RawRepresentable{
    case profileImage
    case firstName
    case lastName
    case phone
    case email
}

// View -> Presenter Interface
protocol ContactDetailPresentation: class {
    var interactor: ContactDetailInteraction { get }
    var router: ContactDetailRouting { get }
    var sections: Int { get }
    func prepareToShowContactDetail()
    func getNoOfRows(for section: Int) -> Int
    func getDisplayType(for indexPath: IndexPath) -> MetadataDisplayType
    
    func toggleFavorite()
    
    var contact: Contact! { get }
    func routeToEditScreen()
}

class ContactDetailPresenter: ContactDetailPresentation {
    
    var interactor: ContactDetailInteraction
    var router: ContactDetailRouting
    weak var viewInterface: ContactDetailViewInterface?
    private let disposeBag = DisposeBag()
    private(set) var contact: Contact!
    
    init(interactor: ContactDetailInteraction,
         router: ContactDetailRouting, contact: Contact) {
        self.interactor = interactor
        self.router = router
        self.contact = contact
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
                self.contact = contact
                self.viewInterface?.showContactExtraDetail(contact: contact)
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.viewInterface?.showNoContactError()
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
                self.viewInterface?.showContactDetail(contact: contact)
                
                }, onError: { [weak self] (error: Error) in
                    guard let self = self else {
                        return
                    }
                    self.viewInterface?.showNoContactError()
            })
            .disposed(by: disposeBag)
    }
    
    func routeToEditScreen() {
        router.routeToEditScreen(with: contact)
    }
}
