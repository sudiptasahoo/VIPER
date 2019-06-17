//
//  ContactEditRouter.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation

final class ContactEditRouter: ContactEditRoutable{
    
    weak var view: ContactEditViewController?
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}
