//
//  ContactListProtocols.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 17/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import Foundation
import RxSwift

// MARK:- View -> Presenter Interface
protocol ContactListPresentable: class {
    
    ///Gives no of sections for UITableView datasource
    var sections: Int { get }
    
    ///Gives no of rows for UITableView datasource
    func getRows(at section: Int) -> Int
    
    ///Loads Contacts from API
    func loadContacts()
    
    ///Opens the Contact Details fpr contact at indexPath
    func selectContact(at indexPath: IndexPath)
    
    ///Returns Section name for Section Header
    func getSectionName(at index: Int) -> String?
    
    ///Returns all the possible section names in an array at once
    func getSectionNames() -> [String]?
    
    ///Returns Contact at indexPath
    func getContact(at indexPath: IndexPath) -> Contact?
    
    ///Routes to Edit Screen with editMode = .new
    func routeToEditScreen()
    
    ///Oberves Contact update tasks happening elsewhere
    var updateTask: PublishSubject<Contact> { get }
}

// MARK:- Presenter -> View Interface
protocol ContactListViewInterface: class {
    
    ///Refreshes the contact list on UI by reloading the tableview
    func refreshContactList()
    
    ///Shows the error occurred during network fetch, on the contact list screen
    func showLoadingError(with errorMessage: String)
}

// MARK:- Presenter -> Interactor
protocol ContactListInteractable {
    
    /**
      Fetches the contacts from the API using the EndPoint provided
        - param: ContactEndPoint which can be understood by the networking layer
        - Returns: RxSwift Observable Array of Contact
     */
    func loadContacts(from endPoint: ContactEndPoint) -> Observable<Dictionary<Character, [Contact]>>
    
    ///Predicate for Sorting logic
    func sortingPredicate(lhs: Character, rhs: Character) -> Bool
    
}

// MARK:- Presenter -> Router
protocol ContactListRoutable {
    
    /**Routes to Contact Details screen
     Initializes the Details screen module with all dependencies and navigates to the same
     */
    func presentContactDetailView(with contact: Contact, inheritedTask: PublishSubject<Contact>)
    
    /**Routes to Contact Edit screen with mode .new
     Initializes the Edit screen module with all dependencies and navigates to the same
     */
    func routeToEditScreen(inheritedTask: PublishSubject<Contact>)
}
