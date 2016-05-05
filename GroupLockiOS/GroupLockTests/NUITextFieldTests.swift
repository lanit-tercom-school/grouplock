//
//  NUITextFieldTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUITextFieldTests: XCTestCase {
    
    let correspondingClass = "TextField"
    
    // System Under Test:
    var sut: UITextField!
    
    var tintColor: UIColor?
    var cornerRadius: Float?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        tintColor    = NUISettings.getColor("tint-color",    withClass: correspondingClass)
        cornerRadius = NUISettings.getFloat("corner-radius", withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: Test Methods
    
    func testSetTintColor() {
        XCTAssertEqual(sut.tintColor, tintColor, "NUI should set UITextField tint color")
    }
    
    func testSetCornerRadius() {
        XCTAssertEqual(Float(sut.layer.cornerRadius), cornerRadius, "NUI should set UITextField corner radius")
    }
}
