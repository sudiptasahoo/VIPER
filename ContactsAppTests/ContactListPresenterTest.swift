//
//  ContactListPresenterTest.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 17/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest
@testable import ContactsApp
import RxSwift


private class MockListInteractor: ContactDetailRoutable{
    
    func routeToEditScreen(with contact: Contact, inheritedTask: PublishSubject<Contact>) {
        
    }
    
    
    private var predicate: (Contact) -> Character = {
        guard let c = $0.firstName?.uppercased().first else { fatalError() }
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numeric = "0123456789"
        if c.isLetter {
            return c
        } else if c.isNumber {
            return "#" as Character
        } else {
            return "?" as Character
        }
    }
    
    
    func loadContacts(from endPoint: ContactEndPoint) -> Observable<Dictionary<Character, [Contact]>> {
        
        return Observable.create {  (observer) -> Disposable in
            
            let mockData = Dictionary(grouping: [Contact()], by: self.predicate)
            
            observer.onNext(mockData)
            observer.onCompleted()
            
            return Disposables.create {
                
            }
        }
        
    }
    
    func sortingPredicate(lhs: Character, rhs: Character) -> Bool {
        
        return true
    }
    
    
    
}

class ContactListPresenterTest: XCTestCase {

    func testSample(){
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
