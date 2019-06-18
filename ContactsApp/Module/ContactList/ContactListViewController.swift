//
//  ContactListViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    var presenter: ContactListPresentable?
    private var tableView: UITableView!
    
    ///Customized Refresh Control for this VC
    lazy private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh(sender:)), for: .valueChanged)
        rc.tintColor = UIColor.signature.withAlphaComponent(0.8)
        return rc
    }()
    
    //MARK:- Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupNavBar()
        
        self.startLoader()
        presenter?.loadContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- Private Methods

    private func setupScreen() {
        
        self.title = "Contact"
        view.signatureThemify()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView.getSignatureTableView(with: view.frame)
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
        
        tableView.register(ContactListingTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    private func setupNavBar() {
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(ContactListViewController.addTapped))
        addItem.accessibilityIdentifier = "add_bar_button"
        navigationItem.rightBarButtonItem = addItem
    }
    
    //MARK:- Acions
    
    @objc private func addTapped() {
        presenter?.routeToEditScreen()
    }
    
    @objc private func handleRefresh(sender: UIRefreshControl) {
        presenter?.loadContacts()
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRows(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = presenter?.getContact(at: indexPath)
        let cell = tableView.dequeueReusableCell(for: indexPath) as ContactListingTableViewCell
        cell.configure(with: contact, at: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.getSectionNames()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.getSectionName(at: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.selectContact(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ContactListViewController : ContactListViewInterface{
    
    func refreshContactList() {
        stopLoader()
        tableView.isHidden = false
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showLoadingError(with errorMessage: String) {
        alert(with: errorMessage)
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}
