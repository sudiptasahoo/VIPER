//
//  UIView+Gradient.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    final func addSignatureGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame = self.bounds

        let color0 = UIColor.pageBackground.cgColor
        let color1 = UIColor.signatureLight.cgColor
        
        layer.colors = [color0,color1]
        self.layer.insertSublayer(layer, at: 0)
    }
}
