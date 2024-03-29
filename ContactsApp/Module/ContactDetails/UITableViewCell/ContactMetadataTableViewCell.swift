//
//  ContactMetadataTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class ContactMetadataTableViewCell: UITableViewCell, CellThemeable, NibReusable {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applySignatureTheme()
    }

    ///Configures the cell UI with Contact and MetadataType
    func configureCell(for contact: Contact?, with metadataType: MetadataType){
        
        guard let contact = contact else {return}
        
        switch metadataType {
        case .phone:
            titleLbl.text = "mobile"
            valueLbl.text = contact.phoneNumber
            valueLbl.accessibilityIdentifier = "mobile"

        case .email:
            titleLbl.text = "email"
            valueLbl.text = contact.email
            valueLbl.accessibilityIdentifier = "email"
            
        default:
            fatalError("Only email and mobile is allowed on Details screen")
        }
        
    }
}
