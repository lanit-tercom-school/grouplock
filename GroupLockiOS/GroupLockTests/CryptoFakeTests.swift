//
//  CryptoFakeTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
class CryptoFakeTests: XCTestCase {

    var sut: CryptoFake!

    let encryptionKey = "014135065011031120213098090225235002159164069053046054089221166018143" +
    "252176014191220128248108194211155076048237028002186"

    let dataToEncrypt = NSData(contentsOfURL:
        NSBundle(forClass: CryptoFakeTests.self).URLForResource("grumpy", withExtension: "jpg")!)!

    override func setUp() {
        super.setUp()

        sut = CryptoFake()
    }

    func test_ThatEncryptedData_IsNotTheSameAsNonEncrypted() {

        // Given

        // When
        let encryptedData = sut.encryptImage(image: dataToEncrypt, withEncryptionKey: encryptionKey)

        // Then
        XCTAssertNotNil(encryptedData, "Encryption should give some result")

        // When
        let initialImage = UIImage(data: dataToEncrypt)
        let encryptedImage = UIImage(data: encryptedData!)

        // Then
        XCTAssertNotNil(encryptedImage, "Encrypted data should still be image-representable")
        XCTAssertFalse(initialImage!.isEqualToImage(encryptedImage!),
                       "Encryption should change an image in some way, right?")
    }

    func test_ThatDecryptingEncryptedImage_GivesIdenticalImage() {

        // Given

        // When
        let encryptedData = sut.encryptImage(image: dataToEncrypt, withEncryptionKey: encryptionKey)
        XCTAssertNotNil(encryptedData)
        let decryptedData = sut.decryptImage(image: encryptedData!, withDecryptionKey: encryptionKey)

        // Then
        XCTAssertNotNil(decryptedData, "Decryption should give some result")

        // When
        let initialImage = UIImage(data: dataToEncrypt)
        let returnedImage = UIImage(data: decryptedData!)
        XCTAssertNotNil(returnedImage, "Decrypted data should be image-representable")
        XCTAssertTrue(initialImage!.isEqualToImage(returnedImage!),
                      "Decrypting an image with the same key as the one used to encrypt it should produce" +
            " initial image")
    }

    func test_EncryptionPerformance() {

        measureBlock { [unowned self] in
            self.sut.encryptImage(image: self.dataToEncrypt, withEncryptionKey: self.encryptionKey)
        }
    }

    func test_DecryptionPerformance() {

        let dataToDecrypt = sut.encryptImage(image: dataToEncrypt, withEncryptionKey: encryptionKey)
        XCTAssertNotNil(dataToDecrypt)

        measureBlock { [unowned self] in
            self.sut.decryptImage(image: dataToDecrypt!, withDecryptionKey: self.encryptionKey)
        }
    }
}
// swiftlint:enable force_unwrapping
