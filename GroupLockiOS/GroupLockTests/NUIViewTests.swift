//
//  NUIViewTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIViewTests: XCTestCase {
    
    let correspondingClass = "View"
    
    // System Under Test:
    var sut: UIView!
    
    var backgroundColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        NUISettings.appendStylesheet("NUITests")
        
        sut = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        backgroundColor = NUISettings.getColor("background-color", withClass: correspondingClass)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: Test Methods
    
    func testSetBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, backgroundColor, "NUI should set UIView background color")
        
    }
    
    func testExcludeSubviewUITextField() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        
        textField.applyNUI()
        
        // Here we take the color of the cursor.
        // Cursor is an instance of UIView, but it must have different color from UIView.
        
        // WARNING: this is a private API, we must not use it in the app itself.
        var cursorColor = textField.valueForKey("textInputTraits")?.valueForKey("insertionPointColor") as! UIColor
        print("\(cursorColor)\n\(sut.backgroundColor!)")
        // We want to check if UIView styling affects the color
        // of a cursor as a subview of UITextField. If it does, that's bad.
        if cursorColor == sut.backgroundColor {
            
            // However in some cases it is possible that a cursor has the same color as UIView background color.
            // So we must keep that in mind and implement deeper test by changing the style class for view and see
            // if the cursor color changes too.
            
            sut.nuiClass = "ViewTest"
            sut.applyNUI()
            textField.applyNUI()
            cursorColor = textField.valueForKey("textInputTraits")?.valueForKey("insertionPointColor") as! UIColor
            
            XCTAssertNotEqual(cursorColor, sut.backgroundColor, "NUI should exclude all the UITextField subviews")
            
        } else {
            XCTAssert(true)
        }
    }
}
