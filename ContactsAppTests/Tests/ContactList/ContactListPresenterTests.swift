//
//  ContactListPresenterTests.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 18/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest
@testable import ContactsApp
import RxSwift


class ContactListPresenterTests: XCTestCase {

    var sut: ContactListPresentable!
    var interactor: ContactListInteractable!
    var mockView: ListMockView!
    
    override func setUp() {
        interactor = ContactListInteractor(NetworkManagerMock.shared)
        sut = ContactListPresenter(interactor: interactor, router: ContactListRouter())
        mockView = ListMockView()
        sut.contactListViewInterface = mockView
        mockView.presenter = sut
    }

    override func tearDown() {
        
        sut = nil
        interactor = nil
        mockView = nil
    }

    func testPresenterLoadContactsSuccess() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertTrue(self.mockView.isSuccess)
            XCTAssertFalse(self.mockView.isError)
        }
    }
    
    func testPresenterNoOfSections() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertEqual(self.mockView.presenter.sections, 4)
        }
    }
    
    func testPresenterNoOfRows() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertEqual(self.mockView.presenter.getRows(at: 0), 1)
            XCTAssertEqual(self.mockView.presenter.getRows(at: 1), 1)
        }
    }
    
    func testPresenterSectionNames() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertEqual(self.mockView.presenter.getSectionNames(), ["R", "W", "#", "?"])
        }
    }
    
    func testPresenterSectionName() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertEqual(self.mockView.presenter.getSectionName(at: 0), "R")
            XCTAssertEqual(self.mockView.presenter.getSectionName(at: 1), "W")
            XCTAssertEqual(self.mockView.presenter.getSectionName(at: 2), "#")
            XCTAssertEqual(self.mockView.presenter.getSectionName(at: 3), "?")
        }
    }
    
    func testPresenterContactAtIndexpath() {
        
        let expect = expectation(description: "Till Network Mock loads the contacts")
        mockView.closure = { () in
            expect.fulfill()
        }
        
        mockView.loadContacts()
        
        waitForExpectations(timeout: 5) { (error) in
            
            XCTAssertEqual(self.mockView.presenter.getContact(at: IndexPath(item: 0, section: 0)), MockContact.shared.contact)
        }
    }

}
