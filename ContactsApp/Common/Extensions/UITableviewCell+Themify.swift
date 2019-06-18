//
//  UITableviewCell+Themify.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

protocol CellThemeable{
    func applySignatureTheme()
}

extension CellThemeable where Self: UITableViewCell{
    
    func applySignatureTheme(){
        contentView.signatureThemify()
        signatureThemify()
    }
}
