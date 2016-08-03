//
//  UIViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class UIViewControllerTests: XCTestCase {

    var window: UIWindow!
    var sut: UIViewController!

    override func setUp() {
        super.setUp()

        window = UIWindow()
        sut = UIViewController()

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

    func testHideKeyboardWhenTappedAround() {
        sut.hideKeyboardWhenTappedAround()
        XCTAssertEqual(sut.view.gestureRecognizers?.count, 1, "View should be able to recognize gestures")

        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.view.addSubview(textField)
        textField.becomeFirstResponder()
        sut.dismissKeyboard()
        XCTAssertFalse(textField.isFirstResponder(), "Text field should lose keyboard focus")
    }

}
