//
//  ProcessedFilePresenterTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try
class ProcessedFilePresenterTests: XCTestCase {

    struct Seeds {
        struct Share {
            static let response = ProcessedFile.Share.Response(dataToShare: [Data(), Data()],
                                                               excludedActivityTypes: [.postToFacebook,
                                                                                       .postToWeibo,
                                                                                       .mail])
        }

        struct Fetch {

            private static let testImageURL = Bundle(for: ProcessedFilePresenterTests.self)
                .url(forResource: "test-image", withExtension: "png")!

            // MARK: Seeds for cases where file contains correct image data
            private static let correctData = [
                (try! Data(contentsOf: testImageURL)),
                (try! Data(contentsOf: testImageURL))
            ]

            private static let fileInfoForCorrectContents = [
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 1",
                    fileThumbnail: UIImage(data: correctData[0])!, encrypted: true),
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 2",
                    fileThumbnail: UIImage(data: correctData[1])!, encrypted: false)
            ]

            private static let filesWithCorrectContents = [
                File(contents: correctData[0], encrypted: true, name: "File 1", type: "JPG"),
                File(contents: correctData[1], encrypted: false, name: "File 2", type: "PNG")
            ]

            static let responseWithCorrectData = ProcessedFile.Fetch.Response(files: filesWithCorrectContents)
            static let viewModelForCorrectData =
                ProcessedFile.Fetch.ViewModel(fileInfo: fileInfoForCorrectContents)

            // MARK: Seeds for cases where file contains incorrect image data or no data at all

            private static let fileInfoForIncorrectContents = [
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 1",
                    fileThumbnail: UIImage(), encrypted: true),
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 2",
                    fileThumbnail: UIImage(), encrypted: false)
            ]

            private static let filesWithIncorrectContents = [
                File(contents: Data(), encrypted: true, name: "File 1", type: "JPG"),
                File(contents: nil, encrypted: false, name: "File 2", type: "JPG")
            ]

            static let responseWithIncorrectData = ProcessedFile.Fetch.Response(files: filesWithIncorrectContents)
            static let viewModelForIncorrectData =
                ProcessedFile.Fetch.ViewModel(fileInfo: fileInfoForIncorrectContents)
        }
    }

    // MARK: Subject under test
    var sut: ProcessedFilePresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut = ProcessedFilePresenter()
    }

    // MARK: - Test doubles

    class ProcessedFilePresenterOutputSpy: ProcessedFilePresenterOutput {

        var shareResponseReceived: ProcessedFile.Share.Response?

        var fetchViewModelReceived: ProcessedFile.Fetch.ViewModel?

        func displayFiles(_ viewModel: ProcessedFile.Fetch.ViewModel) {
            fetchViewModelReceived = viewModel
        }

        func displaySharingInterface(_ response: ProcessedFile.Share.Response) {
            shareResponseReceived = response
        }
    }

    // MARK: - Tests

    func test_ThatProcessedFilePresenter_ForwardsShareResponse() {

        // Given
        let processedFilePresenterOutputSpy = ProcessedFilePresenterOutputSpy()
        sut.output = processedFilePresenterOutputSpy
        let response = Seeds.Share.response

        // When
        sut.shareFiles(response)

        // Then
        let expectedResponse = response
        let returnedResponse = processedFilePresenterOutputSpy.shareResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "ProcessedFilePresenter should invoke displaySharingInterface(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "ProcessedFilePresenter should forward the `Share` response it received to its output")
    }

    func test_ThatProcessedFilePresenter_FormsCorrectFetchViewModelForFilesWithCorrectContents() {

        // Given
        let processedFilePresenterOutputSpy = ProcessedFilePresenterOutputSpy()
        sut.output = processedFilePresenterOutputSpy

        // When
        sut.presentFiles(Seeds.Fetch.responseWithCorrectData)

        // Then
        let expectedViewModel = Seeds.Fetch.viewModelForCorrectData
        let returnedViewModel = processedFilePresenterOutputSpy.fetchViewModelReceived
        XCTAssertNotNil(returnedViewModel,
                        "ProcessedFilePresenter should invoke displayFiles(_:) method on its output")
        XCTAssertEqual(expectedViewModel, returnedViewModel,
                       "ProcessedFilePresenter should form a correct view model when asked to present files")
    }

    func test_ThatProcessedFilePresenter_FormsCorrectFetchViewModelForFilesWithIncorrectContents() {

        // Given
        let processedFilePresenterOutputSpy = ProcessedFilePresenterOutputSpy()
        sut.output = processedFilePresenterOutputSpy

        // When
        sut.presentFiles(Seeds.Fetch.responseWithIncorrectData)

        // Then
        let expectedViewModel = Seeds.Fetch.viewModelForIncorrectData
        let returnedViewModel = processedFilePresenterOutputSpy.fetchViewModelReceived
        XCTAssertNotNil(returnedViewModel,
                        "ProcessedFilePresenter should invoke displayFiles(_:) method on its output")
        XCTAssertEqual(expectedViewModel, returnedViewModel,
                       "ProcessedFilePresenter should form a correct view model even for files with incorrect" +
            " contents or no contents at all")
    }
}
// swiftlint:enable force_unwrapping
// swiftlint:enable force_try
