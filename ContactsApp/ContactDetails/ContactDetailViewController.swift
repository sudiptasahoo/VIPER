//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Networking

final class ContactDetailViewController: UIViewController {
    
    private(set) var contact: Contact!
    private var tableView: UITableView!
    
    init(_ contact: Contact){
        super.init(nibName: nil, bundle: nil)
        self.contact = contact
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupNavBar()
        
        Networking.shared.request(ContactEndPoint.getContact(contact.id)) {[weak self] (result: Result<Contact, Error>) in
            
            switch result{
            case .success(let contact):
                self?.contact = contact
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure( _): break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupScreen(){
        view.signatureThemify()
        tableView = UITableView.getSignatureTableView(with: view.frame)
        view.addSubview(tableView)
        
        tableView.register(ContactHeaderTableViewCell.self)
        tableView.register(ContactMetadataTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(ContactDetailViewController.editTapped))
        
    }
    
    @objc private func editTapped(){
        AppRouter.shared.routeToEditContactDetails(for:contact, mode: .update)
    }
    
    private func getNoOFRows() -> Int{
        var rows = 1
        
        if let ph = contact.phoneNumber, !ph.isEmpty{
            rows += 1
        }
        
        if let email = contact.email, !email.isEmpty{
            rows += 1
        }
        
        return rows
    }
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNoOFRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactHeaderTableViewCell
            cell.configureCell(for: contact)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactMetadataTableViewCell
            cell.configureCell(for: contact, with: .phone)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactMetadataTableViewCell
            cell.configureCell(for: contact, with: .email)
            return cell
            
        default:
            fatalError("Invalid no of rows provided")
        }
        
    }
    
    
}
