//
//  ProvideKeyPresenterTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
class ProvideKeyPresenterTests: XCTestCase {

    struct Seeds {
        static let qrCodeSize: CGSize = {
            let screenSize = UIScreen.main.nativeBounds.size
            let screenWidth = min(screenSize.width, screenSize.height)
            return CGSize(width: screenWidth, height: screenWidth)
        }()

        static let keys = ["Key 1", "Key 2", "Key 3", "Key 4"]
        static let response = ProvideKey.Configure.Response(decryptionKeys: keys)
    }

    // MARK: Subject under test
    var sut: ProvideKeyPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut = ProvideKeyPresenter()
    }

    override func tearDown() {

        super.tearDown()
    }

    // MARK: - Test doubles

    class ProvideKeyPresenterOutputSpy: ProvideKeyPresenterOutput {

        var qrCodes: [UIImage]?

        func displayKeys(_ viewModel: ProvideKey.Configure.ViewModel) {
            qrCodes = viewModel.qrCodes
        }
    }

    // MARK: - Tests

    func test_ThatProvideKeyPresenter_CreatesQRCodes() {

        // Given
        let provideKeyPresenterOutputSpy = ProvideKeyPresenterOutputSpy()
        sut.output = provideKeyPresenterOutputSpy

        // When
        sut.createQRCodes(Seeds.response)

        // Then
        let createdQRCodes = provideKeyPresenterOutputSpy.qrCodes
        XCTAssertNotNil(createdQRCodes,
                        "ProvideKeyPresenter should ask view controller to display created QR-codes")
        let expectedNumberOfQRCodes = Seeds.keys.count
        let actualNumberOfQRCodes = createdQRCodes!.count
        XCTAssertEqual(expectedNumberOfQRCodes, actualNumberOfQRCodes,
                       "ProvideKeyPresenter should create as many QR-codes as keys it was given")
        let allQRCodesAreProperlySized = !createdQRCodes!.contains { $0.size != Seeds.qrCodeSize }
        XCTAssertTrue(allQRCodesAreProperlySized,
                      "ProvideKeyPresenter should create QR-codes so that their image representation fits" +
            " the screen")
    }
}
// swiftlint:enable force_unwrapping
