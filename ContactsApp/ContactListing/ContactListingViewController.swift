//
//  ContactListingViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Networking

enum PageState{
    case loading
    case error
    case normal
}

final class ContactListingViewController: UIViewController {

    private var tableView: UITableView!
    private var contacts = [Contact]()
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()

        Networking.shared.request(ContactEndPoint.getContacts) {[weak self] (result: Result<[Contact], Error>) in
            
            switch result{
            case .success(let contacts):
                self?.contacts = contacts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure( _): break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupScreen(){
        
        self.title = "Contact"
        view.signatureThemify()
        tableView = UITableView.getSignatureTableView(with: view.frame)
        view.addSubview(tableView)
        
        tableView.register(ContactListingTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ContactListingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath) as ContactListingTableViewCell
        cell.configure(with: contact)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = contacts[indexPath.row]
        AppRouter.shared.routeToContactDetails(for: contact)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
