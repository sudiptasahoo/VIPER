//
//  ContactModelTests.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest

class ContactModelTests: XCTestCase {

    func testContactSetGet() {
        let contact = Contact(id: 10, firstName: "Wibin", lastName: "Ayinikat", profilePic: "/mock.png", favorite: true, url: "https://api.example.com/path/value", email: "example@test.com", phoneNumber: "9000090000")
        XCTAssertEqual(contact.id, 10)
        XCTAssertEqual(contact.firstName, "Wibin")
        XCTAssertEqual(contact.lastName, "Ayinikat")
        XCTAssertEqual(contact.profilePic, "/mock.png")
        XCTAssertEqual(contact.favorite, true)
        XCTAssertEqual(contact.url, "https://api.example.com/path/value")
        XCTAssertEqual(contact.email, "example@test.com")
        XCTAssertEqual(contact.phoneNumber, "9000090000")
    }
    
    func testContactDecodable(){
        
    }

}
