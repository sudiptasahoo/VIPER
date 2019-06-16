//
//  ContactEditViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Networking

enum ContactEditMode{
    case new
    case update
}

final class ContactEditViewController: UIViewController {

    private(set) var contact: Contact?
    private(set) var mode: ContactEditMode!

    private var tableView: UITableView!
    
    init(_ contact: Contact?, mode: ContactEditMode){
        super.init(nibName: nil, bundle: nil)
        self.contact = contact
        self.mode = mode
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupScreen(){
        view.signatureThemify()
        tableView = UITableView.getSignatureTableView(with: view.frame)
        setupTableView()
    }
    
    private func setupTableView(){
        tableView = UITableView.getSignatureTableView(with: view.frame)
        view.addSubview(tableView)
        
        tableView.register(EditHeaderTableViewCell.self)
        tableView.register(EditMetadataTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavBar(){
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height, width: view.frame.size.width, height:44))
        navBar.tintColor = .signature
        let navItem = UINavigationItem(title: "")
        let cancelItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(ContactEditViewController.cancelTapped))
        let doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ContactEditViewController.doneTapped))
        navItem.leftBarButtonItem = cancelItem
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        view.addSubview(navBar)
    }
    
    @objc private func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ContactEditViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MetadataType.allCases.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as EditHeaderTableViewCell
            cell.configureCell(for: contact)
            return cell
            
        default:
            guard let type = MetadataType(rawValue: indexPath.row - 1) else {
                fatalError("Wrong values provided in numberOfRowsInSection")
            }
            let cell = tableView.dequeueReusableCell(for: indexPath) as EditMetadataTableViewCell
            cell.configureCell(for: contact, with: type)
            cell.delegate = self
            return cell
        }
    }
    
}

extension ContactEditViewController : EditMetadataCellDelegate{
    
    func textChange(_ text: String?, mode: MetadataType) {
        
        guard let text = text else {return}
        
        switch mode {
        case .phone:
            contact?.phoneNumber = text
            
        case .email:
            contact?.email = text
            
        case .firstName:
            contact?.firstName = text
            
        case .lastName:
            contact?.lastName = text
        }
    }
}
