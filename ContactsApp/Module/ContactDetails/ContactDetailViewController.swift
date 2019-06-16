//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Networking

// Presenter -> View Interface
protocol ContactDetailViewInterface: class {
    var presenter: ContactDetailPresentation? { get set }
    func showNoContactError()
    func showContactExtraDetail(contact: Contact)
    func showContactDetail(contact: Contact)
}

final class ContactDetailViewController: UIViewController {
    
    private var tableView: UITableView!
    var presenter: ContactDetailPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupNavBar()
        
        presenter?.prepareToShowContactDetail()
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
        
        tableView.register(ContactHeaderTableViewCell.self)
        tableView.register(ContactMetadataTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(ContactDetailViewController.editTapped))
        
    }
    
    @objc private func editTapped(){
        //AppRouter.shared.routeToEditContactDetails(for:contact, mode: .update)
    }
    
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNoOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let presenter = presenter else {fatalError("presenter has not been injected")}
        
        switch presenter.getDisplayType(for: indexPath) {
        case .header:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactHeaderTableViewCell
            cell.configureCell(for: presenter.contact)
            cell.delegate = self
            return cell
            
        case .phone:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactMetadataTableViewCell
            cell.configureCell(for: presenter.contact, with: .phone)
            return cell
            
        case .email:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactMetadataTableViewCell
            cell.configureCell(for: presenter.contact, with: .email)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ContactDetailViewController : ContactDetailViewInterface{
    
    func showContactExtraDetail(contact: Contact) {
        self.tableView.reloadSections([1], with: .automatic)
    }
    
    
    func showNoContactError() {
        
    }
    
    func showContactDetail(contact: Contact) {
        self.tableView.reloadData()
    }
    
}

extension ContactDetailViewController : ContactHeaderDelegate, ContactActions{
    
    func messageTapped() {
        guard let phoneNo = presenter?.contact.phoneNumber else {return}
        self.textMessage(to: phoneNo)
    }
    
    func callTapped() {
        guard let phoneNo = presenter?.contact.phoneNumber else {return}
        self.phoneCall(to: phoneNo)
    }
    
    func emailTapped() {
        guard let email = presenter?.contact.email else {return}
        self.draftEmail(to: email)
    }
    
    func favouriteTapped() {
        presenter?.toggleFavorite()
    }
}
