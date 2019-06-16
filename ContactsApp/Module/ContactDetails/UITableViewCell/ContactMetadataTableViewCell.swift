//
//  ContactMetadataTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

enum MetadataType: Int, CaseIterable, RawRepresentable{
    
    case firstName
    case lastName
    case phone
    case email
}

final class ContactMetadataTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.signatureThemify()
    }

    func configureCell(for contact: Contact?, with metadataType: MetadataType){
        
        guard let contact = contact else {return}
        
        switch metadataType {
        case .phone:
            titleLbl.text = "mobile"
            valueLbl.text = contact.phoneNumber

        case .email:
            titleLbl.text = "email"
            valueLbl.text = contact.email
            
        default:
            fatalError("Only email and mobile is allowed on Details screen")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
