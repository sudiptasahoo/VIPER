//
//  UIImageView+Theme.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    final func round(with borderColor: UIColor = .white, borderWidth: CGFloat = 0.0){
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = bounds.width / 2
    }
}
