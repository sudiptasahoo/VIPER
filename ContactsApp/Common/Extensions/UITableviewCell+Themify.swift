//
//  UITableviewCell+Themify.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

protocol CellThemeable{
    func signatureThemify()
}

extension CellThemeable where Self: UITableViewCell{
    
    func signatureThemify(){
        contentView.signatureThemify()
        signatureThemify()
    }
}
