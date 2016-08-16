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

    struct Seeds {
        static let maximumNumberOfKeys = 42
    }

    // MARK: Subject under test
    var sut: NumberOfKeysInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = NumberOfKeysInteractor()
    }

    // MARK: - Test doubles

    class CryptoWrapperFake: CryptoWrapperProtocol {

        let maximumNumberOfKeys = Seeds.maximumNumberOfKeys

        func getKeys(min min: Int, max: Int) -> [String] {
            return []
        }

        func encryptImage(image image: NSData, withEncryptionKey key: String) -> NSData? {
            return NSData()
        }

        func decryptImage(image image: NSData, withDecryptionKey key: String) -> NSData? {
            return NSData()
        }
    }

    // MARK: - Tests

    func test_ThatNumberOfKeysInteractor_FetchesMaximumNumberOfKeysFromCrypto() {

        // Given
        let cryptoWrapperFake = CryptoWrapperFake()
        sut.cryptoLibrary = cryptoWrapperFake


        // When
        let returnedNumber = sut.numberOfKeys

        // Then
        let expectedNumber = Seeds.maximumNumberOfKeys
        XCTAssertEqual(expectedNumber, returnedNumber,
                       "NumberOfKeysInteractor should fetch maximum number of keys from the Crypto class")
    }
}
