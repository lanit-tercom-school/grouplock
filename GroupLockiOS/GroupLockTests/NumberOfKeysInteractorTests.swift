//
//  NumberOfKeysInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class NumberOfKeysInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: NumberOfKeysInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = NumberOfKeysInteractor()
    }

    // MARK: - Test doubles

    // MARK: - Tests

    func test_ThatNumberOfKeysInteractor_FetchesMaximumNumberOfKeysFromCrypto() {

        // Given
        let expectedNumber = Crypto.maximumNumberOfKeys

        // When
        let returnedNumber = sut.numberOfKeys

        // Then
        XCTAssertEqual(expectedNumber, returnedNumber,
                       "NumberOfKeysInteractor should fetch maximum number of keys from the Crypto class")
    }
}
