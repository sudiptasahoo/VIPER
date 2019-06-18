//
//  ContactEditViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 15/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit

final class ContactEditViewController: UIViewController {
    
    var presenter: ContactEditPresentable?
    private var tableView: UITableView!
    
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
        cancelItem.accessibilityIdentifier = "cancel"
        let doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ContactEditViewController.doneTapped))
        doneItem.accessibilityIdentifier = "done"
        navItem.leftBarButtonItem = cancelItem
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        view.addSubview(navBar)
    }
    
    @objc private func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneTapped(){
        
        guard let presenter = presenter else {fatalError("presenter has not been injected")}
        do{
            try presenter.updateContact(contact: presenter.tempContact)
        } catch let error as FieldValidationError{
            alert(with: error.localizedDescription)
        } catch {
            alert(with: "Contact could not be saved")
        }
    }
    
}

extension ContactEditViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNoOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let presenter = presenter else {fatalError("presenter has not been injected")}
        let dType = presenter.getDisplayType(for: indexPath)
        
        switch dType {
            
        case .profileImage:
            
            let cell = tableView.dequeueReusableCell(for: indexPath) as EditHeaderTableViewCell
            cell.configureCell(for: presenter.contact)
            return cell

        case .email, .phone, .firstName, .lastName:
            
            let cell = tableView.dequeueReusableCell(for: indexPath) as EditMetadataTableViewCell
            cell.configureCell(for: presenter.contact, with: dType)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ContactEditViewController : EditMetadataCellDelegate {
    
    func textChange(_ text: String?, mode: MetadataDisplayType) {
        
        guard let t = text  else {return}
        let fText = t.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch mode {
        case .phone:
            presenter?.tempContact.phoneNumber = fText
            
        case .email:
            presenter?.tempContact.email = fText
            
        case .firstName:
            presenter?.tempContact.firstName = fText
            
        case .lastName:
            presenter?.tempContact.lastName = fText
            
        default: break
        }
    }
}

extension ContactEditViewController: ContactEditViewInterface {
    
    func showUpdate(error: Error) {
        alert(with: "Error occured while saving")
    }
}
