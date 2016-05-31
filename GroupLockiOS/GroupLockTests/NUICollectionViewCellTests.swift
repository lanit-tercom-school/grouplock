//
//  NUICollectionViewCellTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUICollectionViewCellTests: XCTestCase {
    
    let correspondingClass = "CollectionViewCell"
    
    // System Under Test:
    var sut: UICollectionViewCell!
    
    var cornerRadius: Float?
    var borderColor: UIColor?
    var borderWidth: Float?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sut.nuiClass = correspondingClass
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        cornerRadius        = NUISettings.getFloat("corner-radius",         withClass: correspondingClass)
        borderColor         = NUISettings.getColor("border-color",          withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    func testSetCornerRadius() {
        XCTAssertEqual(Float(sut.layer.cornerRadius), cornerRadius,
                       "NUI should set UICollectionViewCell corner radius")
    }
    
    func testSetBorderColor() {
        guard let actualBorderColor = sut.layer.borderColor else {
            XCTFail("NUI should set UICollectionViewCell border color")
            return
        }
        
        XCTAssertEqual(UIColor(CGColor: actualBorderColor), borderColor,
                       "NUI should set UICollectionViewCell border color")
    }
    
}