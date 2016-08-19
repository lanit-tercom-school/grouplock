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

        func getKeys(min: Int, max: Int) -> [String] {
            return []
        }

        func validate(key: [String]) -> Bool {
            return false
        }

        func validatePart(_ key: String) -> Bool {
            return false
        }

        func encrypt(image: Data, withEncryptionKey key: [String]) -> Data? {
            return Data()
        }

        func decrypt(image: Data, withDecryptionKey key: [String]) -> Data? {
            return Data()
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
