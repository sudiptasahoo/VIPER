//
//  ContactsAppUITests.swift
//  ContactsAppUITests
//
//  Created by Sudipta Sahoo on 10/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest

enum EditMode{
    case add
    case edit
}

class ContactsAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    let lName = Int.random(in: 99 ..< 999) * Int.random(in: 9 ..< 199)
    let fName = "aaaaaaaaaaaGOJEK"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContactApp() {
        
        //Wait till the Listing page is rendered
        if app.tables["contact_table"].waitForExistence(timeout: 60){
            addContactFlow()
            
            contactDetailFlow()
        }
    }
    
    func addContactFlow(){
        
        let contactNavigationBar = app.navigationBars["Contact"]
        let addBarButtonButton = contactNavigationBar/*@START_MENU_TOKEN@*/.buttons["add_bar_button"]/*[[".buttons[\"Add\"]",".buttons[\"add_bar_button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addBarButtonButton.tap()
        
        editFields(mode: .add)
    }
    
    
    func contactDetailFlow(){
        
        let contactTableTable = app.tables["contact_table"]
        
        //Tap the 1st cell
        contactTableTable.staticTexts["List Row00"].tap()
        
        XCTAssert(app.staticTexts["message"].exists)
        XCTAssert(app.staticTexts["call"].exists)
        XCTAssert(app.staticTexts["email"].exists)
        XCTAssert(app.staticTexts["favourite"].exists)

        let editBarBtn = app.navigationBars["Contact"].buttons["edit"]
        
        if editBarBtn.waitForElementToBeHittable(timeout: 30){
            
            //Tap Edit
            editBarBtn.tap()
            
            editFields(mode: .edit)
            
            //Now new text should appear on the detaisl screen
            if app.staticTexts["\(fName) \(lName)_edit"].waitForExistence(timeout: 60){
                
                XCTAssert(app.staticTexts["\(fName) \(lName)_edit"].exists)
                
                tapFavouriteAndVerify()
            }
        }
        
    }
    
    func tapFavouriteAndVerify(){
        
        let contactTableTable = app.tables["contact_table"]
        let icFavButton = contactTableTable.buttons["ic favourite"]
        let state = icFavButton.isSelected
        
        icFavButton.tap()
        
        if icFavButton.waitForElementToBeSelectable(selected: !state, timeout: 60){
            XCTAssertEqual(icFavButton.isSelected, !state)
        }
    }
    
    func tapBack(){
        app.navigationBars["Contact"].tap()
    }
    
    func scrollToTheEntry(with text: String){
        
        let contactTableTable = app.tables["contact_table"]
        let tableElement = app.tables.element
        
        tableElement.scrollToElement(element: contactTableTable.children(matching: .staticText)[text])
    }
    
    func editFields(mode: EditMode){
        
        let tablesQuery = app.tables
        
        let firstNameTextField = tablesQuery.textFields["first_name"]
        let lastNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["last_name"]/*[[".cells",".textFields[\"Enter Last Name (min 2 characters)\"]",".textFields[\"last_name\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let mobileTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["mobile"]/*[[".cells",".textFields[\"Enter 10 digit Phone no\"]",".textFields[\"mobile\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let emailTextField = tablesQuery.textFields["email"]

        
        switch mode {
        case .edit:
            
            firstNameTextField.tap()
            firstNameTextField.clearAndEnterText(text: fName)

            lastNameTextField.tap()
            lastNameTextField.clearAndEnterText(text: "\(lName)_edit")
            
            mobileTextField.tap()
            mobileTextField.clearAndEnterText(text: "9090909090")
            
            emailTextField.tap()
            emailTextField.clearAndEnterText(text: "gojek@test.com")
            
        case .add:
            
            let firstNameTextField = tablesQuery.textFields["first_name"]
            firstNameTextField.tap()
            firstNameTextField.typeText(fName)
            
            
            let lastNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["last_name"]/*[[".cells",".textFields[\"Enter Last Name (min 2 characters)\"]",".textFields[\"last_name\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
            lastNameTextField.tap()
            lastNameTextField.typeText("\(lName)")
            
            mobileTextField.tap()
            mobileTextField.typeText("9090909090")
            
            emailTextField.tap()
            emailTextField.typeText("gojek@test.com")
            
        }
        
        app.navigationBars.buttons["done"].tap()
    }
    
}
