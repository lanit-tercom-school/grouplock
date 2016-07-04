//
//  NUIGeneralTableTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIGeneralTableTests: XCTestCase {
    
    let correspondingClass = "GeneralTable"
    
    // System Under Test:
    var sut: UITableView!
    
    var backgroundColor: UIColor?
    var separatorColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sut.nuiClass = correspondingClass
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        backgroundColor = NUISettings.getColor("background-color", withClass: correspondingClass)
        separatorColor  = NUISettings.getColor("separator-color",  withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSetBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, backgroundColor, "NUI should set UITableView background color")
    }
    
    func testSetSeparatorColor() {
        XCTAssertEqual(sut.separatorColor, separatorColor, "NUI should set UITableView separator color")
    }
    
}