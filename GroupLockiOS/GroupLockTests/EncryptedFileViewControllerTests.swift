//
//  EncryptedFileViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class EncryptedFileViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: EncryptedFileViewController!
    
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        setupEncryptedFileViewController()
    }
    
    override func tearDown() {
        
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupEncryptedFileViewController() {
        
        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewControllerWithIdentifier("EncryptedFileViewController") as! EncryptedFileViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    // MARK: - Test doubles
    
    // MARK: - Tests

}
