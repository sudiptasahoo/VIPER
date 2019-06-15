//
//  EditMetadataTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

class EditMetadataTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.signatureThemify()
        selectionStyle = .none
    }

    func configureCell(for contact: Contact?, with metadataType: MetadataType){
        
        switch metadataType {
        case .phone:
            titleLbl.text = "mobile"
            valueTextField.text = contact?.phoneNumber
            valueTextField.keyboardType = .phonePad
            
        case .email:
            titleLbl.text = "email"
            valueTextField.text = contact?.email
            valueTextField.keyboardType = .emailAddress

        case .firstName:
            titleLbl.text = "First Name"
            valueTextField.text = contact?.firstName
            valueTextField.keyboardType = .default

        case .lastName:
            titleLbl.text = "Last Name"
            valueTextField.text = contact?.lastName
            valueTextField.keyboardType = .default
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
