//
//  ContactDetailInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking

final class ContactDetailInteractor: ContactDetailInteractable {

    var networking: Networking
    
    //MARK:- Init
    init(_ networking: Networking) {
        self.networking = networking
    }
}
