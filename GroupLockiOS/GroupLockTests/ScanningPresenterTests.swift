//
//  ScanningPresenterTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable variable_name
class ScanningPresenterTests: XCTestCase {

    struct Seeds {

        struct Keys {

            private static let key = "123456789"
            private static let valid = true
            private static let corners = [
                CGPointCreateDictionaryRepresentation(CGPoint(x: 1, y: 23)),
                CGPointCreateDictionaryRepresentation(CGPoint(x: 49, y: 187)),
                CGPointCreateDictionaryRepresentation(CGPoint(x: 13, y: 0)),
                CGPointCreateDictionaryRepresentation(CGPoint(x: 0, y: 3))
            ]
            private static let keys = ["key1", "key2", "key3"]

            static var response: Scanning.Keys.Response {
                return Scanning.Keys.Response(keyScanned: key,
                                              isValidKey: valid,
                                              qrCodeCorners: corners,
                                              keys: keys)
            }

            private static let framePath = CGPath.create([
                CGPoint(x: 1, y: 23),
                CGPoint(x: 49, y: 187),
                CGPoint(x: 13, y: 0),
                CGPoint(x: 0, y: 3)
                ])

            static var viewModel: Scanning.Keys.ViewModel {
                return Scanning.Keys.ViewModel(numberOfDifferentKeys: 3,
                                               qrCodeCGPath: framePath,
                                               isValidKey: true)
            }
        }

        struct CameraError {

            private static let describedError = NSError(
                domain: "Domain",
                code: 420,
                userInfo: [NSLocalizedDescriptionKey : "Localized Description"]
            )

            private static let unknownError = NSError(domain: "Domain", code: 420, userInfo: nil)

            static var responseWithDescribedError: Scanning.CameraError.Response {
                return Scanning.CameraError.Response(error: describedError)
            }

            static var viewModelForDescribedError: Scanning.CameraError.ViewModel {
                return Scanning.CameraError.ViewModel(errorName: "Camera Error",
                                                      errorDescription: "Localized description.")
            }

            static var responseWithUnknownError: Scanning.CameraError.Response {
                return Scanning.CameraError.Response(error: unknownError)
            }

            static var viewModelForUnknownError: Scanning.CameraError.ViewModel {
                return Scanning.CameraError.ViewModel(errorName: "Camera Error",
                                                      errorDescription: "Something went wrong.")
            }
        }
    }

    // MARK: Subject under test
    var sut: ScanningPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut = ScanningPresenter()
    }

    override func tearDown() {

        super.tearDown()
    }

    // MARK: - Test doubles

    class ScanningPresenterOutputSpy: ScanningPresenterOutput {

        var keyScan_viewModel: Scanning.Keys.ViewModel?
        var cameraError_viewModel: Scanning.CameraError.ViewModel?

        func displayKeyScan(viewModel: Scanning.Keys.ViewModel) {
            keyScan_viewModel = viewModel
        }

        func displayCameraErrorMessage(viewModel: Scanning.CameraError.ViewModel) {
            cameraError_viewModel = viewModel
        }
    }

    // MARK: - Tests

    func test_ThatScanningPresenter_FormatsScannedKey() {

        // Given
        let scanningPresenterOutputSpy = ScanningPresenterOutputSpy()
        sut.output = scanningPresenterOutputSpy

        // When
        sut.formatKeyScan(Seeds.Keys.response)
        let actualViewModel = scanningPresenterOutputSpy.keyScan_viewModel

        // Then
        let expectedViewModel = Seeds.Keys.viewModel
        XCTAssertNotNil(actualViewModel, "ScanningPresenter should invoke displayKeyScan method on its output")
        XCTAssertEqual(expectedViewModel, actualViewModel,
                       "ScanningPresenter should form a correct view model for a scanned key")
    }

    func test_ThatScanningPresenter_FormatsDescribedCameraErrorMessage() {

        // Given
        let scanningPresenterOutputSpy = ScanningPresenterOutputSpy()
        sut.output = scanningPresenterOutputSpy

        // When
        sut.formatCameraError(Seeds.CameraError.responseWithDescribedError)
        let actualViewModel = scanningPresenterOutputSpy.cameraError_viewModel

        // Then
        let expectedViewModel = Seeds.CameraError.viewModelForDescribedError
        XCTAssertNotNil(actualViewModel,
                        "ScanningPresenter should invoke displayCameraErrorMessage method on its output")
        XCTAssertEqual(expectedViewModel, actualViewModel,
                       "ScanningPresenter should form a correct view model for a camera error message")

    }
}
// swiftlint:enable variable_name
