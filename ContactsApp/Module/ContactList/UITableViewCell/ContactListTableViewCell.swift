//
//  ContactListingTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class ContactListingTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var favIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.signatureThemify()
        signatureThemify()
        themify()
    }
    
    private func themify(){
        contactImageView.round()
    }
    
    ///It takes Contact object and configures the whole cell. This is the only way to configure the UI of this cell
    func configure(with contact: Contact?){
        
        self.selectionStyle = .none

        guard let contact = contact else {return}
        contactImageView.setImage(contact.profilePic)
        nameLbl.text = "\(contact.firstName ?? "") \(contact.lastName ?? "")"
        setFavIcon(contact.favorite)
    }
    
    private func setFavIcon(_ isFavorite: Bool){
        if isFavorite{
            favIconView.isHidden = false
            favIconView.image = UIImage(named: "ic_home_favourite")
        } else {
            favIconView.isHidden = true
        }
    }
}
