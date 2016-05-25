//
//  NUIEnterPasswordLabelTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUIEnterPasswordLabelTests: XCTestCase {
    
    let correspondingClass = "EnterPasswordLabel"
    
    // System Under Test:
    var sut: UILabel!
    
    var fontColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.nuiClass = "EnterPasswordLabel"
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        fontColor = NUISettings.getColor("font-color", withClass: correspondingClass)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSerFontColor() {
        XCTAssertEqual(sut.textColor, fontColor, "NUI should set UILabel text color")
    }
    
}
