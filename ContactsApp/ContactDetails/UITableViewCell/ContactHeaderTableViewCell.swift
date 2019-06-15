//
//  ContactHeaderTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class ContactHeaderTableViewCell: UITableViewCell, NibReusable {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    private var contact: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.signatureThemify()
        themify()
        setupCell()
    }
    
    private func themify(){
        profileImageView.round(with: .white, borderWidth: 4.0)
        contentView.addSignatureGradient()
    }
    
    private func setupCell(){
        favouriteBtn.setImage(UIImage(named: "ic_favourite_selected"), for: .selected)
        favouriteBtn.setImage(UIImage(named: "ic_favourite"), for: .normal)
    }
    
    func configureCell(for contact: Contact){
        self.contact = contact
        nameLbl.text = "\(contact.firstName) \(contact.lastName)"
        setFavouriteIcon(contact.favorite)
        profileImageView.setImage(contact.profilePic)
        selectionStyle = .none
    }
    
    private func setFavouriteIcon(_ isFavourite: Bool){
        favouriteBtn.isSelected = isFavourite
    }
    
    @IBAction func messageBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func callBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func favouriteBtnAction(_ sender: Any) {
        
    }
    
}
