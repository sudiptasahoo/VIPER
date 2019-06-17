//
//  ContactListingTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

//UITableView cell used for the contact listing tableview
final class ContactListingTableViewCell: UITableViewCell, CellThemeable, NibReusable {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var favIconView: UIImageView!
    
    //MARK:- Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        signatureThemify()
        themifyCell()
    }
    
    //MARK:- Public methods

    ///It takes Contact object and configures the whole cell. This is the only way to configure the UI of this cell
    func configure(with contact: Contact?) {
        
        self.selectionStyle = .none
        guard let contact = contact else {return}
        contactImageView.setImage(contact.profilePic)
        nameLbl.text = contact.fullName
        setFavIcon(contact.favorite)
    }
    
    //MARK:- Private methods
    
    ///Cell and usecase specific themifications are done here
    private func themifyCell() {
        contactImageView.round()
    }
    
    private func setFavIcon(_ isFavorite: Bool) {
        if isFavorite{
            favIconView.isHidden = false
            favIconView.image = UIImage(named: "ic_home_favourite")
        } else {
            favIconView.isHidden = true
        }
    }
}
