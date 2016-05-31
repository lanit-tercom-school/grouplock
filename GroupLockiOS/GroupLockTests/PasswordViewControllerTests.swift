//
//  PasswordViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class PasswordViewControllerTests: XCTestCase {

    var window: UIWindow!
    var sut: PasswordViewController!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        
        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewControllerWithIdentifier(
            "PasswordViewController") as! PasswordViewController
        
        // Load the view
        _ = sut.view
        
        // Add the main view to the view hierarchy
        window.addSubview(sut.view)
        
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    override func tearDown() {
        
        sut = nil
        window = nil
        
        super.tearDown()
    }
    
    func testProceedButton() {
        
        sut.onProceedButton()
        
        XCTAssertFalse(sut.initialPasswordTextField.isFirstResponder(),
                  "initialPasswordTextField should lose keyboard focus")
    }

    func testShowHideProceedButton() {
        XCTAssertTrue(sut.proceedButton.hidden, "Proceed button should be hidden when view is initially loaded")
        
        let textField = UITextField(frame: CGRectZero)
        textField.text = ""
        sut.textFieldOnChange(textField)
        XCTAssertTrue(sut.proceedButton.hidden, "Proceed button should be hidden when the text field is empty")
        
        textField.text = "some text"
        sut.textFieldOnChange(textField)
        XCTAssertFalse(sut.proceedButton.hidden,
                       "Proceed button should not be hidden when the text field contains any text")
        
        textField.text = ""
        sut.textFieldOnChange(textField)
        XCTAssertTrue(sut.proceedButton.hidden, "Proceed button should be hidden when the text field is empty")
    }
    
    func testTextFieldReturn() {
        let textField = UITextField(frame: CGRectZero)
        
        XCTAssert(sut.textFieldShouldReturn(textField), "Text field should process pressing the Return key.")
        XCTAssertFalse(textField.isFirstResponder(), "Text field should lose keyboard focus")
    }
}
