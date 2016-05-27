//
//  NUIGeneralButtonTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIGeneralButtonTests: XCTestCase {
    
    let correspondingClass = "GeneralButton"
    
    // System Under Test:
    var sut: UIButton!
    
    var backgroundColor: UIColor?
    var fontColor: UIColor?
    var cornerRadius: Float?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.nuiClass = correspondingClass
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        backgroundColor = NUISettings.getColor("background-color", withClass: correspondingClass)
        fontColor       = NUISettings.getColor("font-color",       withClass: correspondingClass)
        cornerRadius    = NUISettings.getFloat("corner-radius",    withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSetBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, backgroundColor, "NUI should set UIButton background color")
    }
    
    func testSetTintColor() {
        XCTAssertEqual(sut.currentTitleColor, fontColor, "NUI should set UIButton font color")
    }
    
    func testSetCornerRadius() {
        XCTAssertEqual(Float(sut.layer.cornerRadius), cornerRadius, "NUI should set UIButton corner radius")
    }
    
}
