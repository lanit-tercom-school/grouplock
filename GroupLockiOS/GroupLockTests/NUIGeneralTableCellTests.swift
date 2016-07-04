//
//  NUIGeneralTableCellTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIGeneralTableCellTests: XCTestCase {
    
    let correspondingClass = "GeneralTableCell"
    
    // System Under Test:
    var sut: UITableViewCell!
    
    var backgroundColor: UIColor?
    var tintColor: UIColor?
    var backgroundColorSelected: UIColor?
    var fontColorHighlighted: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        sut = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.nuiClass = correspondingClass
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        backgroundColor         = NUISettings.getColor("background-color",          withClass: correspondingClass)
        tintColor               = NUISettings.getColor("tint-color",                withClass: correspondingClass)
        backgroundColorSelected = NUISettings.getColor("background-color-selected", withClass: correspondingClass)
        fontColorHighlighted    = NUISettings.getColor("font-color-highlighted",    withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSetBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, backgroundColor, "NUI should set UITableViewCell background color")
    }
    
    func testSetTintColor() {
        XCTAssertEqual(sut.tintColor, tintColor, "NUI should set UITableViewCell tint color")
    }
    
    func testSetBackgroundColorSelected() {
        XCTAssertEqual(sut.selectedBackgroundView?.backgroundColor, backgroundColorSelected,
                       "NUI should set selected UITableViewCell background color")
    }
    
    func testSetFontColorHighlighted() {
        XCTAssertEqual(sut.textLabel?.highlightedTextColor, fontColorHighlighted,
                       "NUI should set highlighted UITableViewCell font color")
    }
}
