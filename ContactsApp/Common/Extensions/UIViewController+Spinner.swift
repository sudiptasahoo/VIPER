//
//  UIViewController+Spinner.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    var loaderTag: Int { return 783648 }
    
    @discardableResult
    func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    func addFullScreenBlurView(){
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurView = UIVisualEffectView(frame: self.view.frame)
            blurView.effect = blurEffect
            self.view.addSubview(blurView)
        }
    }
    
    func startLoader(loadingText: String? = nil) {
        
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: .extraLight)
            let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            activityIndicatorView.center = self.view.center
            let loaderView = UIVisualEffectView(frame: self.view.frame)
            loaderView.tag = self.loaderTag
            loaderView.effect = blurEffect
            activityIndicatorView.startAnimating()
            loaderView.contentView.addSubview(activityIndicatorView)
            self.view.addSubview(loaderView)
        }
    }
    
    
    func stopLoader(){
        DispatchQueue.main.async {
            if let loaderView = self.view.subviews.filter(
                { $0.tag == self.loaderTag}).first as? UIVisualEffectView {
                loaderView.removeFromSuperview()
            }
        }
    }
    
    func alert(with message: String? = AppConstants.Defaults.ERROR_MESSAGE, title: String? = AppConstants.Defaults.ERROR_TITLE, actionButtonTitle: String? = AppConstants.Defaults.ERROR_OK_BUTTON_TEXT){
        
        let alertController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        if let buttonTitle = actionButtonTitle{
            let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
