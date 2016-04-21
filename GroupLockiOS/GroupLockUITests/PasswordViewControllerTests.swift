//
//  PasswordViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 19.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest

class PasswordViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        XCUIApplication().terminate()
        super.tearDown()
    }
    
    func testKeyboardApperarsAndDisappears() {
        
        let keyboard = XCUIApplication().keyboards.element
        XCTAssertEqual(keyboard.exists, true)
        
        XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0).tap()
        XCTAssertEqual(keyboard.exists, false)
    }
    
    func testProceedButtonAppearsAndDisappears() {
        
        let app = XCUIApplication()
        let proceedButton = XCUIApplication().buttons["Proceed"]
        
        app.descendantsMatchingType(.SecureTextField).element.typeText("a")
        XCTAssertEqual(proceedButton.hittable, true)
        
        if app.keyboards.keys["delete"].exists {
            app.keyboards.keys["delete"].tap()
        } else {
            app.keyboards.keys["Delete"].tap()
        }
        XCTAssertEqual(proceedButton.hittable, false)
    }
    
    func testProceedButtonPerformsSegue() {
        let app = XCUIApplication()
        let proceedButton = XCUIApplication().buttons["Proceed"]
        
        app.descendantsMatchingType(.SecureTextField).element.typeText("a")
        proceedButton.tap()
        XCTAssertEqual(app.tabBars.element.exists, true)
    }
}

