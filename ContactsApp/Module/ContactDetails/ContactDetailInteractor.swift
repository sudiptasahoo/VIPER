//
//  ContactDetailInteractor.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import Networking
import RxSwift


// MARK:- Interaction Protocol
protocol ContactDetailInteraction: ContactCRUDable {

}

class ContactDetailInteractor: ContactDetailInteraction {

    var networking: Networking
    
    /// Init
    init(_ networking: Networking) {
        self.networking = networking
    }
}
