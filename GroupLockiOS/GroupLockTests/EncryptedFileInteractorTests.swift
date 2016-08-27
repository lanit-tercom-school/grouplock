//
//  EncryptedFileInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class EncryptedFileInteractorTests: XCTestCase {

    struct Seeds {

        struct Fetch {
            static let response = EncryptedFile.Fetch.Response(files: [
                File(contents: nil, encrypted: true, name: "File 1", type: "JPG"),
                File(contents: nil, encrypted: true, name: "File 2", type: "PNG"),
                ])
        }

        struct Share {
            private static let dataToShareAfterFilesWereSelected = [fileContents[0]!, fileContents[1]!]
            private static let dataToShareAfterFileWasDeselected = [fileContents[0]!]
            private static let excludedActivityTypes: [UIActivityType] = [
                .print,
                .postToVimeo,
                .postToWeibo,
                .postToFlickr,
                .postToTwitter,
                .postToFacebook,
                .addToReadingList,
                .postToTencentWeibo
                ].sorted(by: { $0.rawValue < $1.rawValue })

            static let responseAfterFilesWereSelected = EncryptedFile.Share.Response(
                dataToShare: dataToShareAfterFilesWereSelected, excludedActivityTypes: excludedActivityTypes)

            static let responseAfterFileWasDeselected = EncryptedFile.Share.Response(
                dataToShare: dataToShareAfterFileWasDeselected, excludedActivityTypes: excludedActivityTypes)

            static let selectedFilesIndexPaths = [
                IndexPath(item: 0, section: 0),
                IndexPath(item: 1, section: 0)
            ]

            static let deselectedFileIndexPath = IndexPath(item: 1, section: 0)
        }

        struct SaveFiles {

        }

        private static let fileContents = [
            "data1".data(using: String.Encoding.isoLatin1),
            "data2".data(using: String.Encoding.isoLatin1),
        ]

        static let files = [
            File(contents: fileContents[0], encrypted: false, name: "File 1", type: "JPG"),
            File(contents: fileContents[1], encrypted: false, name: "File 2", type: "PNG"),
        ]
    }

    // MARK: Subject under test
    var sut: EncryptedFileInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = EncryptedFileInteractor()
        sut.files = Seeds.files
    }

    // MARK: - Test doubles

    class EncryptedFileInteractorOutputSpy: EncryptedFileInteractorOutput {

        var fetchResponseReceived: EncryptedFile.Fetch.Response?
        var shareResponseReceived: EncryptedFile.Share.Response?

        func presentFiles(_ response: EncryptedFile.Fetch.Response) {
            fetchResponseReceived = response
        }

        func shareFiles(_ response: EncryptedFile.Share.Response) {
            shareResponseReceived = response
        }
    }

    // MARK: - Tests

    func test_ThatEncryptedFileInteractor_FormsCorrectResponseWhenAskedToFetchFiles() {

        // Given
        let encryptedFileInteractorOutputSpy = EncryptedFileInteractorOutputSpy()
        sut.output = encryptedFileInteractorOutputSpy
        let predicate = NSPredicate { object, _ in
            (object as! EncryptedFileInteractorOutputSpy).fetchResponseReceived != nil
        }
        expectation(for: predicate,
                                                      evaluatedWith: encryptedFileInteractorOutputSpy)

        // When
        sut.encryptFiles(EncryptedFile.Fetch.Request())

        // Then
        let expectedResponse = Seeds.Fetch.response

        waitForExpectations(timeout: 1) { _ in
            let returnedResponse = encryptedFileInteractorOutputSpy.fetchResponseReceived
            XCTAssertEqual(expectedResponse, returnedResponse,
                           "EncryptedFileInteractor should form a correct Fetch.Response and send it" +
                " to its output")
        }
    }

    func test_ThatEncryptedFileInteractor_PreparesSelectedFilesForSharing() {

        // Given
        let encryptedFileInteractorOutputSpy = EncryptedFileInteractorOutputSpy()
        sut.output = encryptedFileInteractorOutputSpy
        sut.encryptedFiles = Seeds.files

        // When
        for selectedFileIndexPath in Seeds.Share.selectedFilesIndexPaths {
            sut.fileSelected(EncryptedFile.SelectFiles.Request(indexPath: selectedFileIndexPath))
        }
        sut.prepareFilesForSharing(EncryptedFile.Share.Request())

        // Then
        let expectedResponse = Seeds.Share.responseAfterFilesWereSelected
        let returnedResponse = encryptedFileInteractorOutputSpy.shareResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "EncryptedFileInteractor should invoke shareFiles(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "EncryptedFileInteractor should form a correct Share.Response out of selected files" +
            " and send it to its output")
    }

    func test_ThatEncryptedFileInteractor_PreparesSelectedButNotDeselectedFilesForSharing() {

        // Given
        let encryptedFileInteractorOutputSpy = EncryptedFileInteractorOutputSpy()
        sut.output = encryptedFileInteractorOutputSpy
        sut.encryptedFiles = Seeds.files

        // When
        for selectedFileIndexPath in Seeds.Share.selectedFilesIndexPaths {
            sut.fileSelected(EncryptedFile.SelectFiles.Request(indexPath: selectedFileIndexPath))
        }
        sut.fileDeselected(EncryptedFile.SelectFiles.Request(indexPath: Seeds.Share.deselectedFileIndexPath))
        sut.prepareFilesForSharing(EncryptedFile.Share.Request())

        // Then
        let expectedResponse = Seeds.Share.responseAfterFileWasDeselected
        let returnedResponse = encryptedFileInteractorOutputSpy.shareResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "EncryptedFileInteractor should invoke shareFiles(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "EncryptedFileInteractor should form a correct Share.Response out of selected files" +
            " (even if some, but not all of them were later deselected) and send it to its output")
    }
}
