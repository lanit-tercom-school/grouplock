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
        
        XCTAssert(!sut.initialPasswordTextField.isFirstResponder(),
                  "initialPasswordTextField should lose keyboard focus")
    }

    
}
