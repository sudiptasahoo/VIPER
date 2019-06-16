//
//  UITableView+Defaults.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    class final func getSignatureTableView(with frame: CGRect) -> UITableView{
        
        let tableView = UITableView(frame: frame)
        tableView.sectionIndexBackgroundColor = .clear
        tableView.backgroundColor = .pageBackground
        tableView.backgroundView?.backgroundColor = .pageBackground
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }
}
