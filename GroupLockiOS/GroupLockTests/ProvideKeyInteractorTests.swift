//
//  ProvideKeyInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
class ProvideKeyInteractorTests: XCTestCase {

    struct Seeds {
        static let keys = ["Key 1", "Key 2", "Key 3"]
    }

    // MARK: Subject under test
    var sut: ProvideKeyInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = ProvideKeyInteractor()
    }

    override func tearDown() {

        super.tearDown()
    }

    // MARK: - Test doubles

    class CryptoWrapperFake: CryptoWrapperProtocol {

        let maximumNumberOfKeys = -1

        func getKeys(min min: Int, max: Int) -> [String] {
            return Seeds.keys
        }
        func validate(key key: String) -> Bool {
            return false
        }

        func encryptImage(image image: NSData, withEncryptionKey key: String) -> NSData? {
            return NSData()
        }

        func decryptImage(image image: NSData, withDecryptionKey key: String) -> NSData? {
            return NSData()
        }
    }

    class ProvideKeyInteractorOutputSpy: ProvideKeyInteractorOutput {

        var decryptionKeys: [String]?

        func createQRCodes(response: ProvideKey.Configure.Response) {
            decryptionKeys = response.decryptionKeys
        }
    }

    // MARK: - Tests

    func test_ThatProvideKeyInteractor_fetchesDecryptionKeys() {

        // Given
        let cryptoWrapperFake = CryptoWrapperFake()
        let provideKeyInteractorOutputSpy = ProvideKeyInteractorOutputSpy()
        sut.cryptoLibrary = cryptoWrapperFake
        sut.output = provideKeyInteractorOutputSpy

        // When
        sut.getKeys(ProvideKey.Configure.Request())

        // Then
        let expectedKeys = Seeds.keys
        let actualKeys = provideKeyInteractorOutputSpy.decryptionKeys
        XCTAssertNotNil(actualKeys,
                        "ProvideKeyInteractor should ask the presenter to create QR-codes with given keys")
        XCTAssertEqual(expectedKeys, actualKeys!,
                       "ProvideKeyInteractor should ask the crypto library for decryption keys and send them" +
            " to the presenter")
    }
}
// swiftlint:enable force_unwrapping
