//
//  ContactActions.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

protocol ContactActions: class {
    
    func phoneCall(to phoneNo: String)
    func textMessage(to phoneno: String, _ message: String)
    func draftEmail(to email: String, subject: String, body: String)
}

extension ContactActions where Self: UIViewController{
    
    func phoneCall(to phoneNo: String){
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNo)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func textMessage(to phoneno: String, _ message: String = AppConstants.Defaults.TEXT_MESSAGE_BODY){
        
        let composeVC = MFMessageComposeViewController()
        //composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [phoneno]
        composeVC.body = message
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func draftEmail(to email: String, subject: String = AppConstants.Defaults.EMAIL_SUBJECT, body: String = AppConstants.Defaults.EMAIL_BODY){
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            //mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setMessageBody("<p>\(body)</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
}
