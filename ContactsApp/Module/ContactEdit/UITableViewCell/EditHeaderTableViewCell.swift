//
//  EditHeaderTableViewCell.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class EditHeaderTableViewCell: UITableViewCell, CellThemeable, NibReusable {

    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        signatureThemify()
        themify()
    }
    
    private func themify(){
        profileImageView.round(with: .white, borderWidth: 4.0)
        contentView.addSignatureGradient()
        separatorInset.right = .greatestFiniteMagnitude
    }
    
    func configureCell(for contact: Contact?){
        profileImageView.setImage(contact?.profilePic, placeHolderImage: UIImage(named: "placeholder_photo"))
        selectionStyle = .none
    }
    
    
    @IBAction func uploadPhotoTapped(_ sender: Any) {
        //To be implemented
        print("To be implemented ...")
    }
}
