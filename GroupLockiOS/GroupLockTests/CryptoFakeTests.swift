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

        // Then
        XCTAssertNotNil(returnedImage, "Decrypted data should be image-representable")
        XCTAssertTrue(initialImage!.isEqualToImage(returnedImage!),
                      "Decrypting an image with the same key as the one used to encrypt it should produce the" +
            " initial image")
    }

    func test_ThatCryptoFake_GeneratesEncryptionKey() {

        // Given

        // When
        let key = sut.getKeys(min: 1, max: 1).first

        // Then
        XCTAssertNotNil(key)
        XCTAssertEqual(key?.characters.count, 120, "120-digit key should be generated")

        // When
        let encryptedData = sut.encryptImage(image: dataToEncrypt, withEncryptionKey: key!)
        XCTAssertNotNil(encryptedData, "The key generated should be valid encryption key")
    }

    func test_ThatValidateMethod_ValidatesKey() {

        // Given
        let validKey = encryptionKey
        let wrongNumbersKey = "999367-11876"
        let wrongCharactersKey = "abcdefghijklmnopqrstuvwxyz"
        let tooShortKey = "123123123"
        let incompleteKey = "12312312312"
        let emptyKey = ""

        // When

        // Then
        XCTAssertTrue(sut.validate(key: validKey), "validate method should return true for a truly valid key")
        XCTAssertFalse(sut.validate(key: wrongNumbersKey), "Key with numbers out of range 0–255 is not valid")
        XCTAssertFalse(sut.validate(key: wrongCharactersKey), "Key with symbols other than numbers is not valid")
        XCTAssertFalse(sut.validate(key: tooShortKey), "Key should be at least 12 characters long")
        XCTAssertFalse(sut.validate(key: incompleteKey),
                       "Key with number of digits that is not a multiple of 3 is not valid")
        XCTAssertFalse(sut.validate(key: emptyKey), "Empty key is not valid")
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
