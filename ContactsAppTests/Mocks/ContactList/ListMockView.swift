//
//  ListMockView.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
@testable import ContactsApp

class ListMockView: ContactListViewInterface{
    
    var closure: (()->Void)?
    var presenter: ContactListPresentable!
    
    var isSuccess = false
    var isError = false
    
    func loadContacts(){
        presenter.loadContacts()
    }
    
    func refreshContactList() {
        isSuccess = true
        isError = false
        closure?()
    }
    
    func showLoadingError(with errorMessage: String) {
        isSuccess = false
        isError = true
        closure?()
    }
}
