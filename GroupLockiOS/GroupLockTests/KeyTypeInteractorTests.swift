//
//  KeyTypeInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class KeyTypeInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: KeyTypeInteractor!
    
    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        
        sut = KeyTypeInteractor()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    // MARK: - Tests
    
    func test_ThatKeyTypeInteractor_SetsKeyTypeForQRCode() {
        
        // Given
        let request = KeyTypeModels.SetType.Request(keyName: "QR-CODE")
        
        // When
        sut.setKeyType(request)
        
        // Then
        let expectedValue = KeyType.QRCode
        let returnedValue = sut.keyType
        
        XCTAssertEqual(expectedValue, returnedValue, "setKeyType method should set the correct value of the keyType variable")
    }
    
    func test_ThatKeyTypeInteractor_SetsDefaultKeyTypeForInvalidKeyName() {
        
        // Given
        let expectedValue = sut.keyType
        let request = KeyTypeModels.SetType.Request(keyName: "Invalid key name")
        
        // When
        sut.setKeyType(request)
        
        // Then
        let returnedValue = sut.keyType
        
        XCTAssertEqual(expectedValue, returnedValue,
                       "setKeyType method should not change the value of the keyType variable if the key name is invalid")
    }
}
