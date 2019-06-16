//
//  ContactEditRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

protocol ContactEditRouting: class {
    var view: ContactEditViewController? { get set }
    func dismiss()
}

class ContactEditRouter: ContactEditRouting{
    
    weak var view: ContactEditViewController?
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}
