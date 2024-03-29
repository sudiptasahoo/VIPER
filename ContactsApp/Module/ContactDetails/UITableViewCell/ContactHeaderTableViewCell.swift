//
//  ContactHeaderTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

protocol ContactHeaderDelegate: class{
    func messageTapped()
    func callTapped()
    func emailTapped()
    func favouriteTapped()
}

final class ContactHeaderTableViewCell: UITableViewCell, NibReusable, CellThemeable {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    weak var delegate: ContactHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applySignatureTheme()
        themify()
        setupCell()
    }
    
    ///It takes Contact object and configures the whole cell. This is the only way to configure the UI of this cell
    func configureCell(for contact: Contact?){
        
        selectionStyle = .none
        
        guard let contact = contact else {return}
        nameLbl.text = contact.fullName
        setFavouriteIcon(contact.favorite)
        profileImageView.setImage(contact.profilePic)
        accessibilityLabel = contact.fullName
    }
    
    // MARK:- Private methods
    
    ///Cell and usecase specific themifications are done here
    private func themify(){
        profileImageView.round(with: .white, borderWidth: 4.0)
        contentView.addSignatureGradient()
    }
    
    ///Configure the cell params
    private func setupCell(){
        favouriteBtn.setImage(UIImage(named: "ic_favourite_selected"), for: .selected)
        favouriteBtn.setImage(UIImage(named: "ic_favourite"), for: .normal)
        separatorInset.right = .greatestFiniteMagnitude
    }
    
    
    private func setFavouriteIcon(_ isFavourite: Bool){
        favouriteBtn.isSelected = isFavourite
    }
    
    @IBAction func messageBtnAction(_ sender: Any) {
        delegate?.messageTapped()
    }
    
    @IBAction func callBtnAction(_ sender: Any) {
        delegate?.callTapped()
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        delegate?.emailTapped()
    }
    
    @IBAction func favouriteBtnAction(_ sender: Any) {
        delegate?.favouriteTapped()
    }
    
}
