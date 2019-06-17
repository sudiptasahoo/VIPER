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
    
    /**
     Sets the image from the path to the UIImageView
     if path starts with http or https then image is directly fetched from this path
     else path is prefixed with BASE_URL and then image is fetched
     
     - parameter path: The URL of the image. https://www.example.com/image.png or /image.png
     - paramter placeHolderImage: Placeholder image to be put on the UIImageView until the image is fetched
 */
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
