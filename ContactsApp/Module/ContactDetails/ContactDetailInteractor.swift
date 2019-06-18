//
//  ContactDetailInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

final class ContactDetailInteractor: ContactDetailInteractable {

    var networking: NetworkManageable
    
    //MARK:- Init
    init(_ networking: NetworkManageable) {
        self.networking = networking
    }
}
