//
//  NUIPasswordViewTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIPasswordViewTests: XCTestCase {
    
    let correspondingClass = "PasswordView"
    
    // System Under Test:
    var sut: UIView!
    
    var backgroundColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sut.nuiClass = "PasswordView"
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
    
}