//
//  ContactModelTests.swift
//  ContactsAppTests
//
//  Created by Sudipta Sahoo on 16/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactModelTests: XCTestCase {

    func testContactSetGet() {
        
        var contact = Contact()
        contact.id = 10
        contact.firstName = "Wibin"
        contact.lastName = "Ayinikat"
        contact.profilePic = "/mock.png"
        contact.favorite = true
        contact.url = "https://api.example.com/path/value"
        contact.email = "example@test.com"
        contact.phoneNumber = "9000090000"
        
        XCTAssertEqual(contact.id, 10)
        XCTAssertEqual(contact.firstName, "Wibin")
        XCTAssertEqual(contact.lastName, "Ayinikat")
        XCTAssertEqual(contact.fullName, "Wibin Ayinikat")
        XCTAssertEqual(contact.profilePic, "/mock.png")
        XCTAssertEqual(contact.favorite, true)
        XCTAssertEqual(contact.url, "https://api.example.com/path/value")
        XCTAssertEqual(contact.email, "example@test.com")
        XCTAssertEqual(contact.phoneNumber, "9000090000")
    }
    
    func testContactDecodable(){
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let contact = try? decoder.decode(Contact.self, from: MockContact.shared.contactJson.data(using: String.Encoding.utf8) ?? Data())
       
        XCTAssertNotNil(contact)
        XCTAssertEqual(contact!.firstName, MockContact.shared.contact.firstName)
        XCTAssertEqual(contact!.lastName, MockContact.shared.contact.lastName)
        XCTAssertEqual(contact!.phoneNumber, MockContact.shared.contact.phoneNumber)
        XCTAssertEqual(contact!.email, MockContact.shared.contact.email)
        XCTAssertEqual(contact!.fullName, MockContact.shared.contact.fullName)

    }

}
