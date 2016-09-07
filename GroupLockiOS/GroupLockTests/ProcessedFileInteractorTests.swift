//
//  ProcessedFileInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class ProcessedFileInteractorTests: XCTestCase {

    struct Seeds {

        struct Fetch {
            static let encryptionResponse = ProcessedFile.Fetch.Response(files: [
                File(contents: nil, encrypted: true, name: "File 1", type: "JPG"),
                File(contents: nil, encrypted: true, name: "File 2", type: "PNG"),
                ])
            static let decryptionResponse = ProcessedFile.Fetch.Response(files: [
                File(contents: nil, encrypted: false, name: "File 1", type: "JPG"),
                File(contents: nil, encrypted: false, name: "File 2", type: "PNG"),
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

            static let responseAfterFilesWereSelected = ProcessedFile.Share.Response(
                dataToShare: dataToShareAfterFilesWereSelected, excludedActivityTypes: excludedActivityTypes)

            static let responseAfterFileWasDeselected = ProcessedFile.Share.Response(
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
    var sut: ProcessedFileInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = ProcessedFileInteractor()
        sut.files = Seeds.files
    }

    // MARK: - Test doubles

    class ProcessedFileInteractorOutputSpy: ProcessedFileInteractorOutput {

        var fetchResponseReceived: ProcessedFile.Fetch.Response?
        var shareResponseReceived: ProcessedFile.Share.Response?

        func presentFiles(_ response: ProcessedFile.Fetch.Response) {
            fetchResponseReceived = response
        }

        func shareFiles(_ response: ProcessedFile.Share.Response) {
            shareResponseReceived = response
        }
    }

    class CryptoWrapperSpy: CryptoWrapperProtocol {

        var encryptionCounter = 0
        var decryptionCounter = 0

        let maximumNumberOfKeys = 15

        func getKeys(min: Int, max: Int) -> [String] {
            return []
        }

        func validate(key: [String]) -> Bool {
            return true
        }

        func validatePart(_ key: String) -> Bool {
            return true
        }

        func encrypt(image: Data, withEncryptionKey key: [String]) -> Data? {
            encryptionCounter += 1
            return image
        }

        func decrypt(image: Data, withDecryptionKey key: [String]) -> Data? {
            decryptionCounter += 1
            return image
        }
    }

    // MARK: - Tests

    func test_ThatProcessedFileInteractor_FormsCorrectResponseWhenAskedToEncryptFiles() {

        // Given
        let processedFileInteractorOutputSpy = ProcessedFileInteractorOutputSpy()
        sut.output = processedFileInteractorOutputSpy
        sut.isEncryption = true
        let predicate = NSPredicate { object, _ in
            (object as! ProcessedFileInteractorOutputSpy).fetchResponseReceived != nil
        }
        expectation(for: predicate, evaluatedWith: processedFileInteractorOutputSpy)

        // When
        sut.processFiles(ProcessedFile.Fetch.Request())

        // Then
        let expectedResponse = Seeds.Fetch.encryptionResponse

        waitForExpectations(timeout: 1) { _ in
            let returnedResponse = processedFileInteractorOutputSpy.fetchResponseReceived
            XCTAssertEqual(expectedResponse, returnedResponse,
                           "ProcessedFileInteractor should form a correct Fetch.Response and send it" +
                " to its output")
        }
    }

    func test_ThatProcessedFileInteractor_FormsCorrectResponseWhenAskedToDecryptFiles() {

        // Given
        let processedFileInteractorOutputSpy = ProcessedFileInteractorOutputSpy()
        sut.output = processedFileInteractorOutputSpy
        sut.isEncryption = false
        let predicate = NSPredicate { object, _ in
            (object as! ProcessedFileInteractorOutputSpy).fetchResponseReceived != nil
        }
        expectation(for: predicate, evaluatedWith: processedFileInteractorOutputSpy)

        // When
        sut.processFiles(ProcessedFile.Fetch.Request())

        // Then
        let expectedResponse = Seeds.Fetch.decryptionResponse

        waitForExpectations(timeout: 1) { _ in
            let returnedResponse = processedFileInteractorOutputSpy.fetchResponseReceived
            XCTAssertEqual(expectedResponse, returnedResponse,
                           "ProcessedFileInteractor should form a correct Fetch.Response and send it" +
                " to its output")
        }
    }

    func test_ThatProcessedFileInteractor_PreparesSelectedFilesForSharing() {

        // Given
        let processedFileInteractorOutputSpy = ProcessedFileInteractorOutputSpy()
        sut.output = processedFileInteractorOutputSpy
        sut.processedFiles = Seeds.files

        // When
        for selectedFileIndexPath in Seeds.Share.selectedFilesIndexPaths {
            sut.fileSelected(ProcessedFile.SelectFiles.Request(indexPath: selectedFileIndexPath))
        }
        sut.prepareFilesForSharing(ProcessedFile.Share.Request())

        // Then
        let expectedResponse = Seeds.Share.responseAfterFilesWereSelected
        let returnedResponse = processedFileInteractorOutputSpy.shareResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "ProcessedFileInteractor should invoke shareFiles(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "ProcessedFileInteractor should form a correct Share.Response out of selected files" +
            " and send it to its output")
    }

    func test_ThatProcessedFileInteractor_PreparesSelectedButNotDeselectedFilesForSharing() {

        // Given
        let processedFileInteractorOutputSpy = ProcessedFileInteractorOutputSpy()
        sut.output = processedFileInteractorOutputSpy
        sut.processedFiles = Seeds.files

        // When
        for selectedFileIndexPath in Seeds.Share.selectedFilesIndexPaths {
            sut.fileSelected(ProcessedFile.SelectFiles.Request(indexPath: selectedFileIndexPath))
        }
        sut.fileDeselected(ProcessedFile.SelectFiles.Request(indexPath: Seeds.Share.deselectedFileIndexPath))
        sut.prepareFilesForSharing(ProcessedFile.Share.Request())

        // Then
        let expectedResponse = Seeds.Share.responseAfterFileWasDeselected
        let returnedResponse = processedFileInteractorOutputSpy.shareResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "ProcessedFileInteractor should invoke shareFiles(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "ProcessedFileInteractor should form a correct Share.Response out of selected files" +
            " (even if some, but not all of them were later deselected) and send it to its output")
    }

    func test_ThatProcessedFileInteractor_AsksCryptoLibraryToEncryptFiles() {

        // Given
        let cryptoWrapperSpy = CryptoWrapperSpy()
        sut.cryptoLibrary = cryptoWrapperSpy
        sut.output = ProcessedFileInteractorOutputSpy()
        sut.isEncryption = true
        let predicate = NSPredicate { object, _ -> Bool in
            (object as! CryptoWrapperSpy).encryptionCounter > 0
        }
        expectation(for: predicate, evaluatedWith: cryptoWrapperSpy)

        // When
        sut.processFiles(ProcessedFile.Fetch.Request())

        // Then
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("ProcessFileInteractor should ask crypto library to encrypt files if isEncryption is" +
                    " set to true")
            }
        }
    }

    func test_ThatProcessedFileInteractor_AsksCryptoLibraryToDecryptFiles() {

        // Given
        let cryptoWrapperSpy = CryptoWrapperSpy()
        sut.cryptoLibrary = cryptoWrapperSpy
        sut.output = ProcessedFileInteractorOutputSpy()
        sut.isEncryption = false
        let predicate = NSPredicate { object, _ -> Bool in
            (object as! CryptoWrapperSpy).decryptionCounter > 0
        }
        expectation(for: predicate, evaluatedWith: cryptoWrapperSpy)

        // When
        sut.processFiles(ProcessedFile.Fetch.Request())

        // Then
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("ProcessFileInteractor should ask crypto library to decrypt files if isEncryption is" +
                    " set to false")
            }
        }
    }
}
// swiftlint:enbale force_cast
