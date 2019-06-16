//
//  UIViewController+Spinner.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
//    var vSpinner: UIView?
//    
//    func showSpinner(onView : UIView) {
//        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
//        ai.startAnimating()
//        ai.center = spinnerView.center
//        
//        DispatchQueue.main.async {
//            spinnerView.addSubview(ai)
//            onView.addSubview(spinnerView)
//        }
//        
//        vSpinner = spinnerView
//    }
//    
//    func removeSpinner() {
//        DispatchQueue.main.async {
//            vSpinner?.removeFromSuperview()
//            vSpinner = nil
//        }
//    }
    
    func alert(with title: String?, message: String?, actionButtonTitle: String?){
        
        let alertController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        if let buttonTitle = actionButtonTitle{
            let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
