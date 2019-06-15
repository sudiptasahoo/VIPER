//
//  EditHeaderTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

class EditHeaderTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.signatureThemify()
        themify()
    }
    
    private func themify(){
        profileImageView.round(with: .white, borderWidth: 4.0)
        contentView.addSignatureGradient()
    }
    
    func configureCell(for contact: Contact?){
        profileImageView.setImage(contact?.profilePic, placeHolderImage: UIImage(named: "placeholder_photo"))
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func uploadPhotoTapped(_ sender: Any) {
    }
}
