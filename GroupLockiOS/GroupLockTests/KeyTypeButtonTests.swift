//
//  KeyTypeButtonTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class KeyTypeButtonTests: XCTestCase {
    
    let correspondingClass = "KeyTypeButton"
    
    // System Under Test:
    var sut: UIButton!
    
    var backgroundColor: UIColor?
    var backgroundColorSelected: UIImage? // We use UIImage because we can't directly set background color
    var backgroundColorDisabled: UIImage? // for a particular state, so we set it as an image.
    var fontColor: UIColor?
    var fontColorSelected: UIColor?
    var tintColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.nuiClass = correspondingClass
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        backgroundColor         = NUISettings.getColor("background-color",
                                                       withClass: correspondingClass)
        backgroundColorSelected = NUISettings.getImageFromColor("background-color-selected",
                                                                withClass: correspondingClass)
        backgroundColorDisabled = NUISettings.getImageFromColor("background-color-disabled",
                                                       withClass: correspondingClass)
        fontColor               = NUISettings.getColor("font-color",
                                                       withClass: correspondingClass)
        fontColorSelected       = NUISettings.getColor("font-color-selected",
                                                       withClass: correspondingClass)
        tintColor               = NUISettings.getColor("tint-color",
                                                       withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSetBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, backgroundColor, "NUI should set UIButton background color")
    }
    
    func testSetBackgroundColorSelected() {
        sut.selected = true
        
        if let currentBackgroundImage = sut.currentBackgroundImage {
            let currentBackgroundImageData = UIImagePNGRepresentation(currentBackgroundImage)
            let expectedBackgroundImageData = UIImagePNGRepresentation(backgroundColorSelected!)
            
            XCTAssertEqual(currentBackgroundImageData, expectedBackgroundImageData,
                           "NUI should set UIButton selected background color")
        } else {
            XCTFail("NUI should set UIButton selected background color")
        }
    }
    
    func testSetBackgroundColorDisabled() {
        sut.enabled = false
        
        if let currentBackgroundImage = sut.currentBackgroundImage {
            let currentBackgroundImageData = UIImagePNGRepresentation(currentBackgroundImage)
            let expectedBackgroundImageData = UIImagePNGRepresentation(backgroundColorDisabled!)
            
            XCTAssertEqual(currentBackgroundImageData, expectedBackgroundImageData,
                           "NUI should set UIButton disabled background color")
        } else {
            XCTFail("NUI should set UIButton selected disabled color")
        }
    }
    
    func testSetFontColor() {
        XCTAssertEqual(sut.titleColorForState(.Normal), fontColor, "NUI should set UIButton font color")
    }
    
    func testSetFontColorSelected() {
        XCTAssertEqual(sut.titleColorForState(.Selected), fontColorSelected,
                       "NUI should set UIButton selected font color")
    }
    
    func testSetTintColor() {
        XCTAssertEqual(sut.tintColor, tintColor, "NUI should set UIButton selected font color")
    }
}
