//
//  UIImageView+Cache.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import ImageCache

extension UIImageView{
    
    func setImage(_ path: String?, placeHolderImage: UIImage? = nil){
        
        guard let path = path else {
            self.ss_setImage(nil, placeHolderImage)
            return
        }
        
        //Detecting whether relative image path has been provided or absolute image path is provided
        var url: URL!
        if path.hasPrefix("http"){
            url = URL(string: path)
        } else{
            url = URL(string: "\(AppConstants.Networking.BASE_URL)\(path)")
        }
        
        self.ss_setImage(url, placeHolderImage)
    }

}
