//
//  ProvideKeyViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping
class ProvideKeyViewControllerTests: XCTestCase {

    struct Seeds {

        static let viewModel = ProvideKey.Configure.ViewModel(qrCodes: [UIImage(), UIImage()])
        static let indexPathDummy = NSIndexPath(forItem: 0, inSection: 0)
        static let indexPathToSelect = NSIndexPath(forItem: 1, inSection: 0)
    }

    // MARK: Subject under test
    var sut: ProvideKeyViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupProvideKeyViewController()
    }

    override func tearDown() {

        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupProvideKeyViewController() {

        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard
            .instantiateViewControllerWithIdentifier("ProvideKeyViewController") as! ProvideKeyViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }

    // MARK: - Test doubles

    class ProvideKeyViewControllerOutputSpy: ProvideKeyViewControllerOutput {

        // swiftlint:disable:next variable_name
        var getKeys_called = false

        var files: [File] = []
        var numberOfKeys = (0, 0)
        func getKeys(request: ProvideKey.Configure.Request) {
            getKeys_called = true
        }
    }

    class CollectionViewConfiguratorSpy: CollectionViewConfiguratorProtocol {
        var collectionViewConfigurated: UICollectionView?
        var allowsMultipleSelection: Bool?
        func configure(collectionView: UICollectionView, allowsMultipleSelection: Bool) {
            collectionViewConfigurated = collectionView
            self.allowsMultipleSelection = allowsMultipleSelection
        }
    }

    class CollectionViewMock: UICollectionView {

        // swiftlint:disable:next variable_name
        let _cell: ProvideKeyCell = {
            let cell = ProvideKeyCell(frame: .zero)
            cell.darkeningView = UIView()
            cell.keyImageView = UIImageView()
            return cell
        }()

        override func cellForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewCell? {
            return _cell
        }
    }

    class AgrumeSpy: ImageViewer {

        var shown = false
        var initialImageIndex = -1

        func showImageAtIndex(index: Int) {
            initialImageIndex = index
        }

        func showFrom(viewController: UIViewController) {
            shown = true
        }

        var didScroll: ((index: Int) -> Void)?
    }

    // MARK: - Tests

    func test_ThatProvideKeyViewController_CausesFetchingDecryptionKeysOnLoad() {

        // Given
        let provideKeyViewControllerOutputSpy = ProvideKeyViewControllerOutputSpy()
        sut.output = provideKeyViewControllerOutputSpy

        // When
        loadView()

        // Then
        XCTAssertTrue(provideKeyViewControllerOutputSpy.getKeys_called,
                      "EncryptedFileViewController should tell the interactor to fetch decryption keys from" +
            " the crypto library once the view is loaded")
    }

    func test_ThatProvideKeyViewController_ConfiguresCollectionViewOnLoad() {

        // Given
        let collectionViewConfiguratorSpy = CollectionViewConfiguratorSpy()
        sut.collectionViewConfigurator = collectionViewConfiguratorSpy

        // When
        loadView()

        // Then
        XCTAssertNotNil(collectionViewConfiguratorSpy.collectionViewConfigurated,
                        "ProvideKeyViewController should tell CollectionViewConfigurator to configure" +
            " its collection view")
        XCTAssertNotNil(collectionViewConfiguratorSpy.allowsMultipleSelection)
        XCTAssertTrue(sut.collectionView === collectionViewConfiguratorSpy.collectionViewConfigurated,
                      "ProvideKeyViewController should pass CollectionViewConfigurator its collection view")
        XCTAssertTrue(collectionViewConfiguratorSpy.allowsMultipleSelection!,
                      "ProvideKeyViewController should allow multiple selection in its collection view")
    }

    func test_ThatProvideKeyViewController_SetsCollectionViewDataSource() {

        // Given

        // When
        sut.displayKeys(with: Seeds.viewModel)

        // Then
        XCTAssertTrue(sut.dataSourceProvider.collectionViewDataSource === sut.collectionView!.dataSource,
                      "ProvideKeyViewController should set collection view data source")
    }

    func test_ThatCollectionViewCellFactory_ConfiguresSelectedCell() {

        // Given
        let cell = ProvideKeyCell(frame: .zero)
        cell.selected = true
        cell.keyImageView = UIImageView()
        cell.darkeningView = UIView()

        // When
        sut.displayKeys(with: Seeds.viewModel)
        let returnedCell = sut.dataSourceProvider.cellFactory.configure(view: cell,
                                                                        item: nil,
                                                                        type: .cell,
                                                                        parentView: sut.collectionView!,
                                                                        indexPath: Seeds.indexPathDummy)

        // Then
        XCTAssertFalse(returnedCell.darkeningView.hidden,
                       "CollectionViewCellFactory should darken a cell if it is selected")
    }

    func test_ThatCollectionViewCellFactory_ConfiguresDeselectedCell() {

        // Given
        let cell = ProvideKeyCell(frame: .zero)
        cell.selected = false
        cell.keyImageView = UIImageView()
        cell.darkeningView = UIView()

        // When
        sut.displayKeys(with: Seeds.viewModel)
        let returnedCell = sut.dataSourceProvider.cellFactory.configure(view: cell,
                                                                        item: nil,
                                                                        type: .cell,
                                                                        parentView: sut.collectionView!,
                                                                        indexPath: Seeds.indexPathDummy)

        // Then
        XCTAssertTrue(returnedCell.darkeningView.hidden,
                      "CollectionViewCellFactory should not darken a cell if it is deselected")
    }

    func test_ThatCollectionViewCellFactory_SetsQRCodeImage() {

        // Given
        let cell = ProvideKeyCell(frame: .zero)
        cell.keyImageView = UIImageView()
        cell.darkeningView = UIView()
        let qrCodeImage = UIImage()

        // When
        sut.displayKeys(with: Seeds.viewModel)
        let returnedCell = sut.dataSourceProvider.cellFactory.configure(view: cell,
                                                                        item: qrCodeImage,
                                                                        type: .cell,
                                                                        parentView: sut.collectionView!,
                                                                        indexPath: Seeds.indexPathDummy)

        // Then
        XCTAssertTrue(returnedCell.keyImageView.image === qrCodeImage,
                      "CollectionViewCellFactory should set QR-code image for a cell")
    }

    func test_ThatProvideKeyViewController_DarkensViewedKey() {

        // Given
        let collectionViewMock = CollectionViewMock(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
        sut.collectionView = collectionViewMock
        let cell = sut.collectionView!.cellForItemAtIndexPath(Seeds.indexPathToSelect) as! ProvideKeyCell

        // When
        sut.displayKeys(with: Seeds.viewModel)
        sut.collectionView!.selectItemAtIndexPath(Seeds.indexPathToSelect, animated: false, scrollPosition: .None)
        sut.collectionView(sut.collectionView!, didSelectItemAtIndexPath: Seeds.indexPathToSelect)

        // Then
        XCTAssertFalse(cell.darkeningView.hidden, "QR-code should be darkened after it's tapped")
    }

    func test_ThatProvideKeyViewController_PresentsAgrumeViewController() {

        // Given
        let agrumeSpy = AgrumeSpy()
        sut.agrume = agrumeSpy

        // When
        sut.displayKeys(with: Seeds.viewModel)
        sut.collectionView!.selectItemAtIndexPath(Seeds.indexPathToSelect, animated: false, scrollPosition: .None)
        sut.collectionView(sut.collectionView!, didSelectItemAtIndexPath: Seeds.indexPathToSelect)

        // Then
        XCTAssertTrue(agrumeSpy.shown,
                      "ProvideKeyViewController should present Agrume view controller when a QR-code is tapped")
        let expectedInitialImageIndex = Seeds.indexPathToSelect.item
        let actualInitialImageIndex = agrumeSpy.initialImageIndex
        XCTAssertEqual(expectedInitialImageIndex, actualInitialImageIndex,
                       "When Agrume is presented, it should show an image of QR-code that has been tapped")

        // When

        // Resetting this spy properties so we can test that Agrume is presented even when we tap on an already
        // viewed QR-code
        agrumeSpy.shown = false
        agrumeSpy.initialImageIndex = -1
        sut.collectionView!.deselectItemAtIndexPath(Seeds.indexPathToSelect, animated: false)
        let shouldDeselect = sut.collectionView(sut.collectionView!,
                                                shouldDeselectItemAtIndexPath: Seeds.indexPathToSelect)

        // Then
        XCTAssertFalse(shouldDeselect,
                       "Viewed QR-codes should be marked as selected, so they cannot be deselected")
        XCTAssertTrue(agrumeSpy.shown,
                      "ProvideKeyViewController should present Agrume view controller when a QR-code" +
            "is tapped even if it's been viewed")

    }

    func test_ThatAgrume_ProcessesScrolling() {

        // Given
        let collectionViewMock = CollectionViewMock(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
        sut.collectionView = collectionViewMock
        let cell = sut.collectionView!.cellForItemAtIndexPath(Seeds.indexPathToSelect) as! ProvideKeyCell

        sut.displayKeys(with: Seeds.viewModel)
        sut.collectionView!.selectItemAtIndexPath(Seeds.indexPathToSelect, animated: false, scrollPosition: .None)
        sut.collectionView(sut.collectionView!, didSelectItemAtIndexPath: Seeds.indexPathToSelect)
        XCTAssertNotNil(sut.agrume.didScroll, "Agrume should process scrolling")
        // Resetting some cell properties so we can test that Agrume sets them when scrolling
        cell.darkeningView.hidden = true
        cell.selected = false

        // When
        sut.agrume.didScroll!(index: Seeds.indexPathToSelect.item)

        // Then
        XCTAssertFalse(cell.darkeningView.hidden, "Agrume should darken scrolled QR-codes")
        XCTAssertTrue(cell.selected, "Agrume should select scrolled QR-codes")
    }
}
// swiftlint:enable force_cast
// swiftlint:enable force_unwrapping
