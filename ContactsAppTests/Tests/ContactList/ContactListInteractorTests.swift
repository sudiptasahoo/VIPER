//
//  ContactListInteractorTests.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest
@testable import ContactsApp
import RxSwift

class ContactListInteractorTests: XCTestCase {
    
    var presenter: ListMockPresenter!
    var sut: ContactListInteractable!
    
    override func setUp() {
        sut = ContactListInteractor(NetworkManagerMock.shared)
        presenter = ListMockPresenter(interactor: sut)
    }
    
    override func tearDown() {
        
        presenter = nil
        sut = nil
    }
    
    func testLoadContactWithSuccess() {
        
        let expect = expectation(description: "Till interactor loads the contacts from mock network")
        presenter.closure = { () in
            expect.fulfill()
        }
        presenter.endPoint = ContactMockEndPoint.contactsSuccess
        presenter.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertTrue(self.presenter.isSuccess)
            XCTAssertFalse(self.presenter.isError)
            
        }
    }
    
    
    func testLoadContactWithFailure() {
        
        let expect = expectation(description: "Till interactor loads the contacts from mock network")
        presenter.closure = { () in
            expect.fulfill()
        }
        presenter.endPoint = ContactMockEndPoint.contactsFailure
        presenter.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertFalse(self.presenter.isSuccess)
            XCTAssertTrue(self.presenter.isError)
            
        }
    }
    
    func testLoadContactAndVerifyReturnedContacts() {
        
        let expect = expectation(description: "Till interactor loads the contacts from mock network")
        presenter.closure = { () in
            expect.fulfill()
        }
        presenter.endPoint = ContactMockEndPoint.contactsSuccess
        presenter.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertNotNil(self.presenter.contactModel)
            XCTAssertEqual(self.presenter.contactModel?.keys.count, 4)
            XCTAssertEqual(self.presenter.contactModel?["W" as Character]?.count, 1)
            XCTAssertEqual(self.presenter.contactModel?["R" as Character]?.count, 1)
        }
    }
}
