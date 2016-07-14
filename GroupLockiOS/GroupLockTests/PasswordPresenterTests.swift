//
//  PasswordPresenterTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class PasswordPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: PasswordPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = PasswordPresenter()
    }
    
    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    // MARK: - Tests
    
}
