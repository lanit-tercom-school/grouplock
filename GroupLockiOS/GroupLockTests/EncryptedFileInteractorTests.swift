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
            static let response = EncryptedFile.Fetch.Response(files: encryptedFiles)
        }
        
        struct Share {
            private static let dataToShareAfterFilesWereSelected = [fileContents[1]!, NSData()]
            private static let dataToShareAfterFileWasDeselected = [fileContents[1]!]
            private static let excludedActivityTypes = [
                UIActivityTypePrint,
                UIActivityTypePostToVimeo,
                UIActivityTypePostToWeibo,
                UIActivityTypePostToFlickr,
                UIActivityTypePostToTwitter,
                UIActivityTypePostToFacebook,
                UIActivityTypeAddToReadingList,
                UIActivityTypePostToTencentWeibo
                ].sort()
            
            static let responseAfterFilesWereSelected = EncryptedFile.Share.Response(
                dataToShare: dataToShareAfterFilesWereSelected, excludedActivityTypes: excludedActivityTypes)
            
            static let responseAfterFileWasDeselected = EncryptedFile.Share.Response(
                dataToShare: dataToShareAfterFileWasDeselected, excludedActivityTypes: excludedActivityTypes)
            
            static let selectedFilesIndexPaths = [
                NSIndexPath(forItem: 1, inSection: 0),
                NSIndexPath(forItem: 2, inSection: 0)
            ]
            
            static let deselectedFileIndexPath = NSIndexPath(forItem: 2, inSection: 0)
        }
        
        struct SaveFiles {
            
        }
        
        private static let fileContents = [
            "data1".dataUsingEncoding(NSISOLatin1StringEncoding),
            "data2".dataUsingEncoding(NSISOLatin1StringEncoding),
            nil
        ]
        
        static let encryptedFiles = [
            File(name: "File 1", type: "JPG", encrypted: true, contents: fileContents[0]),
            File(name: "File 2", type: "PNG", encrypted: false, contents: fileContents[1]),
            File(name: "File 3", type: "TIFF", encrypted: true, contents: fileContents[2])
        ]
    }
    
    // MARK: Subject under test
    var sut: EncryptedFileInteractor!
    
    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        
        sut = EncryptedFileInteractor()
        sut.encryptedFiles = Seeds.encryptedFiles
    }
    
    // MARK: - Test doubles
    
    class EncryptedFileInteractorOutputSpy: EncryptedFileInteractorOutput {
        
        var fetchResponseReceived: EncryptedFile.Fetch.Response?
        var shareResponseReceived: EncryptedFile.Share.Response?
        
        func presentFiles(response: EncryptedFile.Fetch.Response) {
            fetchResponseReceived = response
        }
        
        func shareFiles(response: EncryptedFile.Share.Response) {
            shareResponseReceived = response
        }
    }
    
    // MARK: - Tests
    
    func test_ThatEncryptedFileInteractor_FormsCorrectResponseWhenAskedToFetchFiles() {
        
        // Given
        let encryptedFileInteractorOutputSpy = EncryptedFileInteractorOutputSpy()
        sut.output = encryptedFileInteractorOutputSpy
        
        // When
        sut.fetchFiles(EncryptedFile.Fetch.Request())
        
        // Then
        let expectedResponse = Seeds.Fetch.response
        let returnedResponse = encryptedFileInteractorOutputSpy.fetchResponseReceived
        XCTAssertNotNil(returnedResponse,
                        "EncryptedFileInteractor should invoke presentFiles(_:) method on its output")
        XCTAssertEqual(expectedResponse, returnedResponse,
                       "EncryptedFileInteractor should form a correct Fetch.Response and send it to its output")
    }
    
    func test_ThatEncryptedFileInteractor_PreparesSelectedFilesForSharing() {
        
        // Given
        let encryptedFileInteractorOutputSpy = EncryptedFileInteractorOutputSpy()
        sut.output = encryptedFileInteractorOutputSpy
        
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
