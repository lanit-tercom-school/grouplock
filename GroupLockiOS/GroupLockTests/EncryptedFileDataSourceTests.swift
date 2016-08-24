//
//  EncryptedFileDataSourceTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class EncryptedFileDataSourceTests: XCTestCase {

    struct Seeds {

        typealias FileInfo = EncryptedFile.Fetch.ViewModel.FileInfo

        static let fileInfo = [
            FileInfo(fileName: "File 1", fileThumbnail: UIImage(), encrypted: true),
            FileInfo(fileName: "File 2", fileThumbnail: UIImage(), encrypted: false),
            FileInfo(fileName: "File 3", fileThumbnail: UIImage(), encrypted: true),
            FileInfo(fileName: "File 4", fileThumbnail: UIImage(), encrypted: false),
            FileInfo(fileName: "File 5", fileThumbnail: UIImage(), encrypted: true)
        ]
        static let viewModel = EncryptedFile.Fetch.ViewModel(fileInfo: fileInfo)
        static var numberOfItems: Int { return fileInfo.count }
        static let indexPathForEncryptedFile = IndexPath(item: 2, section: 0)
        static let indexPathForDecryptedFile = IndexPath(item: 3, section: 0)
    }

    // MARK: Subject under test
    var sut: EncryptedFileDataSource!

    var collectionView: UICollectionView!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut = EncryptedFileDataSource()
        sut.updateViewModel(Seeds.viewModel)

        sut.cellProvider = FileCollectionViewCellProviderStub(reuseIdentifier: "Dummy")

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = sut
    }

    // MARK: - Test doubles

    class FileCollectionViewCellProviderStub: FileCollectionViewCellProviderProtocol {

        private let providesSelectedCells: Bool

        required init(reuseIdentifier: String) {
            providesSelectedCells = false
        }

        init(providesSelectedCells: Bool) {
            self.providesSelectedCells = providesSelectedCells
        }

        func cell(for collectionView: UICollectionView, at indexPath: IndexPath) -> FileCollectionViewCell {
            let cell = FileCollectionViewCellMock()
            cell.filenameLabel = UILabel()
            cell.thumbnailView = UIImageView()
            cell.lockIcon = UIImageView()
            cell.isSelected = providesSelectedCells
            return cell
        }
    }

    class FileCollectionViewCellMock: FileCollectionViewCell {

        var visualizeSelection_called = false // swiftlint:disable:this variable_name
        var visualizeDeselection_called = false // swiftlint:disable:this variable_name

        override func visualizeSelection() {
            visualizeSelection_called = true
        }

        override func visualizeDeselection() {
            visualizeDeselection_called = true
        }
    }

    // MARK: - Tests

    func test_ThatEncryptedFileDataSource_ReturnsCorrectNumberOfItemsInSection() {

        // Given

        // When
        let returnedNumberOfItems = sut.collectionView(collectionView, numberOfItemsInSection: 0)

        // Then
        let expectedNumberOfItems = Seeds.numberOfItems
        XCTAssertEqual(expectedNumberOfItems, returnedNumberOfItems,
                       "EncryptedFileDataSource should return exactly the number of items in the view model")
    }

    func test_ThatEncryptedFileDataSource_ReturnsCorrectlyFormattedCell() {

        // Given

        // When
        let cell = sut.collectionView(
            collectionView, cellForItemAt: Seeds.indexPathForEncryptedFile) as! FileCollectionViewCell

        // Then
        let returnedFileName = cell.filenameLabel.text
        let returnedThumbnail = cell.thumbnailView.image
        let expectedFileName = Seeds.fileInfo[Seeds.indexPathForEncryptedFile.item].fileName
        let expectedThumbnail = Seeds.fileInfo[Seeds.indexPathForEncryptedFile.item].fileThumbnail

        XCTAssertEqual(expectedFileName, returnedFileName, "EncryptedFileDataSource should present file name")
        XCTAssertTrue(returnedThumbnail === expectedThumbnail,
                      "File thumbnail and an image in a cell should be the same instances")
    }

    func test_ThatEncryptedFileDataSource_CausesCellsToDisplayLockIconForEncryptedFiles() {

        // Given

        // When
        let cell = sut.collectionView(
            collectionView, cellForItemAt: Seeds.indexPathForEncryptedFile) as! FileCollectionViewCell

        // Then
        XCTAssertFalse(cell.lockIcon.isHidden, "Cell should show a lock icon for an encrypted file")
    }

    func test_ThatEncryptedFileDataSource_CausesCellsToHideLockIconForDecryptedFiles() {

        // Given

        // When
        let cell = sut.collectionView(
            collectionView, cellForItemAt: Seeds.indexPathForDecryptedFile) as! FileCollectionViewCell

        // Then
        XCTAssertTrue(cell.lockIcon.isHidden, "Cell should not show a lock icon for a decrypted file")
    }

    func test_ThatEncryptedFileDataSource_TellsCellToVisualizeSelection() {

        // Given
        sut.cellProvider = FileCollectionViewCellProviderStub(providesSelectedCells: true)

        // When
        let cell = sut.collectionView(
            collectionView, cellForItemAt: Seeds.indexPathForEncryptedFile) as! FileCollectionViewCellMock

        // Then
        XCTAssertTrue(cell.visualizeSelection_called,
                      "EncryptedFileDataSource should tell selected cells to visualize their selection")
        XCTAssertFalse(cell.visualizeDeselection_called,
                       "EncryptedFileDataSource should not tell selected cells to visualize their deselection")
    }

    func test_ThatEncryptedFileDataSource_TellsCellToVisualizeDeselection() {

        // Given
        sut.cellProvider = FileCollectionViewCellProviderStub(providesSelectedCells: false)

        // When
        let cell = sut.collectionView(
            collectionView, cellForItemAt: Seeds.indexPathForEncryptedFile) as! FileCollectionViewCellMock

        // Then
        XCTAssertTrue(cell.visualizeDeselection_called,
                      "EncryptedFileDataSource should tell deselected cells to visualize their deselection")
        XCTAssertFalse(cell.visualizeSelection_called,
                       "EncryptedFileDataSource should not tell deselected cells to visualize their selection")
    }
}
// swiftlint:enable force_cast
