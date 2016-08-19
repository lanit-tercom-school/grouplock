//
//  QRCodeTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try
class QRCodeTests: XCTestCase {

    struct Seeds {
        private static let qrCodeURL = Bundle(for: QRCodeTests.self)
            .url(forResource: "QR-Code", withExtension: "png")!

        private static let tooMassiveDataURL = Bundle(for: QRCodeTests.self)
            .url(forResource: "test-image", withExtension: "png")!

        static let validString = "Arbitrary string"
        static let invalidString = "🤔"
        static let qrCodeWidth: CGFloat = 128

        static var qrCodeUIImage = UIImage(named: "QR-Code",
                           in: Bundle(for: QRCodeTests.self),
                           compatibleWith: nil)!

        static var qrCodeCGImage: CGImage { return qrCodeUIImage.cgImage! }

        static let tooMassiveData = try! Data(contentsOf: tooMassiveDataURL)
    }

    // MARK: - Test methods

    func test_ThatQRCodeStruct_CreatesUIImageFromString() {

        // Given
        let qrCode = QRCode(string: Seeds.validString)!

        // When
        let returnedImage = qrCode.createUIImage(width: Seeds.qrCodeWidth)

        // Then
        let expectedImage = Seeds.qrCodeUIImage
        XCTAssertTrue(expectedImage.isEqualToImage(returnedImage), "QRCode should create a correct UIImage object")
    }

    func test_ThatQRCodeStruct_CreatesCGImageFromString() {

        // Given
        let qrCode = QRCode(string: Seeds.validString)!

        // When
        let returnedImage = qrCode.createCGImage(width: Seeds.qrCodeWidth)

        // Then
        let expectedImage = Seeds.qrCodeCGImage
        XCTAssertTrue(expectedImage.isEqualToImage(returnedImage), "QRCode should create a correct CGImage object")
    }

    func test_ThatQRCodeStruct_FailsToInitializeIfStringIsIncorrect() {

        // Given
        let qrCode = QRCode(string: Seeds.invalidString)

        // When

        // Then
        XCTAssertNil(qrCode, "QRCode should fail to initialize in case of invalid string passed to it")
    }

    func test_ThatQRCodeStruct_FailsToInitializeIfBinaryDataIsTooMassive() {

        // Given
        let qrCode = QRCode(data: Seeds.tooMassiveData)

        // When

        // Then
        XCTAssertNil(qrCode, "QRCode should fail to initialize in case of too massive data passed to it")
    }
}
// swiftlint:enable force_unwrapping
// swiftlint:enable force_try
