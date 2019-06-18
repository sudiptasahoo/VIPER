//
//  EditMetadataTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

protocol EditMetadataCellDelegate: class{
    
    ///Notifies as the user types the text
    func textChange(_ text: String?, mode: MetadataDisplayType)
}

final class EditMetadataTableViewCell: UITableViewCell, CellThemeable, NibReusable {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    private var mode: MetadataDisplayType!
    weak var delegate: EditMetadataCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        signatureThemify()
        selectionStyle = .none
    }

    func configureCell(for contact: Contact?, with metadataType: MetadataDisplayType){
        self.mode = metadataType
        switch metadataType {
        case .phone:
            titleLbl.text = "mobile"
            valueTextField.text = contact?.phoneNumber
            valueTextField.keyboardType = .phonePad
            valueTextField.placeholder = "Enter 10 digit Phone no"
            valueTextField.accessibilityIdentifier = "mobile"
            
        case .email:
            titleLbl.text = "email"
            valueTextField.text = contact?.email
            valueTextField.keyboardType = .emailAddress
            valueTextField.placeholder = "Enter Email"
            valueTextField.accessibilityIdentifier = "email"

        case .firstName:
            titleLbl.text = "First Name"
            valueTextField.text = contact?.firstName
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Enter First Name (min 2 characters)"
            valueTextField.accessibilityIdentifier = "first_name"

        case .lastName:
            titleLbl.text = "Last Name"
            valueTextField.text = contact?.lastName
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Enter Last Name (min 2 characters)"
            valueTextField.accessibilityIdentifier = "last_name"
            
        default: fatalError("Invalid Metadata type has been sent to be rendered by EditMetadataTableViewCell")
        }
        
        valueTextField.delegate = self
        valueTextField.addTarget(self, action: #selector(typingText), for: .editingChanged)
    }
    
    @objc func typingText(textField: UITextField) {
        delegate?.textChange(textField.text, mode: mode)
    }
}

extension EditMetadataTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
