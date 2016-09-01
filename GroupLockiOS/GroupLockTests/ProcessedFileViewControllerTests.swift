//
//  ProcessedFileViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping
class ProcessedFileViewControllerTests: XCTestCase {

    struct Seeds {

        struct Fetch {
            static let fileInfo = [
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 1",
                    fileThumbnail: UIImage(), encrypted: false),
                ProcessedFile.Fetch.ViewModel.FileInfo(fileName: "File 2",
                    fileThumbnail: UIImage(), encrypted: true)
            ]

            static let viewModel = ProcessedFile.Fetch.ViewModel(fileInfo: fileInfo)
        }

        struct Share {
            static let response = ProcessedFile.Share.Response(dataToShare: [Data(), Data()],
                                                               excludedActivityTypes: nil)
        }

        struct SelectFiles {
            static let indexPathToSelect = IndexPath(item: 1, section: 0)
            static let indexPathToDeselect = IndexPath(item: 0, section: 0)
        }
    }

    // MARK: Subject under test
    var sut: ProcessedFileViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupProcessedFileViewController()
    }

    // MARK: - Test setup

    func setupProcessedFileViewController() {

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(
            withIdentifier: "ProcessedFileViewController") as! ProcessedFileViewController
    }

    func loadView() {
        window.addSubview(sut.view)

        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles

    class ProcessedFileViewControllerOutputSpy: ProcessedFileViewControllerOutput {

        var fetchFiles_called = false // swiftlint:disable:this variable_name
        var prepareFilesForSharing_called = false // swiftlint:disable:this variable_name
        var saveFiles_called = false // swiftlint:disable:this variable_name

        var selectedFileIndexPath: IndexPath?
        var deselectedFileIndexPath: IndexPath?

        var files: [File] = []
        var processedFiles: [File] = []
        var cryptographicKey = [""]
        var isEncryption = true

        func processFiles(_ request: ProcessedFile.Fetch.Request) {
            fetchFiles_called = true
        }

        func prepareFilesForSharing(_ request: ProcessedFile.Share.Request) {
            prepareFilesForSharing_called = true
        }

        func fileSelected(_ request: ProcessedFile.SelectFiles.Request) {
            selectedFileIndexPath = request.indexPath
        }

        func fileDeselected(_ request: ProcessedFile.SelectFiles.Request) {
            deselectedFileIndexPath = request.indexPath
        }

        func saveFiles(_ request: ProcessedFile.SaveFiles.Request) {
            saveFiles_called = true
        }
    }

    class CollectionViewConfiguratorSpy: CollectionViewConfiguratorProtocol {
        var collectionViewConfigurated: UICollectionView?
        var allowsMultipleSelection: Bool?
        func configure(_ collectionView: UICollectionView, allowsMultipleSelection: Bool) {
            collectionViewConfigurated = collectionView
            self.allowsMultipleSelection = allowsMultipleSelection
        }
    }

    class ProcessedFileDataSourceMock: NSObject, ProcessedFileDataSourceProtocol {

        var viewModelToUpdate: ProcessedFile.Fetch.ViewModel?

        func updateViewModel(_ viewModel: ProcessedFile.Fetch.ViewModel) {
            viewModelToUpdate = viewModel
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Seeds.Fetch.fileInfo.count
        }

        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuse_id")
            return collectionView.dequeueReusableCell(withReuseIdentifier: "reuse_id", for: indexPath)
        }
    }

    class UICollectionViewMock: UICollectionView {

        var dataReloaded = false

        var cellMock: FileCollectionViewCellMock?

        override func reloadData() {
            dataReloaded = true
        }

        // We make sure that reloadData() method is invoked only *after* the data source is updated.
        override var dataSource: UICollectionViewDataSource? {
            didSet {
                dataReloaded = false
            }
        }

        override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
            return cellMock
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

    class ProcessedFileRouterSpy: ProcessedFileRouter {

        var returnToHomeScene_called = false // swiftlint:disable:this variable_name

        override func returnToHomeScene() {
            returnToHomeScene_called = true
        }
    }

    // MARK: - Tests

    func test_ThatProcessedFileViewController_CausesFetchingFilesOnLoad() {

        // Given
        let processedFileViewControllerOutputSpy = ProcessedFileViewControllerOutputSpy()
        sut.output = processedFileViewControllerOutputSpy

        // When
        loadView()

        // Then
        XCTAssertTrue(processedFileViewControllerOutputSpy.fetchFiles_called,
                      "ProcessedFileViewController should tell the interactor to fetch encrypted files" +
            " once the view is loaded")
    }

    func test_ThatProcessedFileViewController_ConfiguresCollectionViewOnLoad() {

        // Given
        let collectionViewConfiguratorSpy = CollectionViewConfiguratorSpy()
        sut.collectionViewConfigurator = collectionViewConfiguratorSpy

        // When
        loadView()

        // Then
        XCTAssertNotNil(collectionViewConfiguratorSpy.collectionViewConfigurated,
                        "ProcessedFileViewController should tell CollectionViewConfigurator to configure" +
            " its collection view")
        XCTAssertNotNil(collectionViewConfiguratorSpy.allowsMultipleSelection)
        XCTAssertTrue(sut.collectionView === collectionViewConfiguratorSpy.collectionViewConfigurated,
                      "ProcessedFileViewController should pass CollectionViewConfigurator its collection view")
        XCTAssertTrue(collectionViewConfiguratorSpy.allowsMultipleSelection!,
                      "ProcessedFileViewController should allow multiple selection in its collection view")
    }

    func test_ThatProcessedFileViewController_displaysFiles() {

        // Given
        loadView()
        let processedFileDataSourceMock = ProcessedFileDataSourceMock()
        let collectionViewMock = UICollectionViewMock(frame: CGRect.zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout())
        sut.collectionViewDataSource = processedFileDataSourceMock
        sut.collectionView = collectionViewMock

        // When
        sut.displayFiles(Seeds.Fetch.viewModel)

        // Then
        let expectedViewModelToSendToUpdate = Seeds.Fetch.viewModel
        let actualViewModelSended = processedFileDataSourceMock.viewModelToUpdate
        XCTAssertNotNil(actualViewModelSended, "displayFiles(_:) method should cause updating view model" +
            " in the data source")
        XCTAssertEqual(expectedViewModelToSendToUpdate, actualViewModelSended,
                       "displayFiles(_:) should update view model in the data source with the view it received")
        XCTAssertTrue(collectionViewMock.dataSource === processedFileDataSourceMock,
                      "displayFiles(_:) should set a correct data source for the collection view")
        XCTAssertTrue(collectionViewMock.dataReloaded,
                      "displayFiles(_:) should reload data in the collection view after setting its data source")
    }

    func test_ThatShareButton_CausesPreparingFilesForSharing() {

        // Given
        let processedFileViewControllerOutputSpy = ProcessedFileViewControllerOutputSpy()
        sut.output = processedFileViewControllerOutputSpy
        let shareButton = UIBarButtonItem()

        // When
        sut.onShareButton(shareButton)

        // Then
        XCTAssertTrue(processedFileViewControllerOutputSpy.prepareFilesForSharing_called,
                      "Share button should invoke prepareFilesForSharing(_:) method on the view" +
            " controller's output")
    }

    func test_ThatSaveButton_CausesSavingFiles() {

        // Given
        let processedFileViewControllerOutputSpy = ProcessedFileViewControllerOutputSpy()
        let processedFileRouterSpy = ProcessedFileRouterSpy()
        sut.output = processedFileViewControllerOutputSpy
        sut.router = processedFileRouterSpy
        let saveButton = UIBarButtonItem()

        // When
        sut.onSaveButton(saveButton)

        // Then
        XCTAssertTrue(processedFileViewControllerOutputSpy.saveFiles_called,
                      "Save button should invoke saveFile(_:) method on the view" +
            " controller's output")
        XCTAssertTrue(processedFileRouterSpy.returnToHomeScene_called,
                      "Save button should unwind to the Home Scene")
    }

    func test_ThatProcessedFileViewController_PresentsActivityViewController() {

        // Given
        loadView()

        // When
        sut.displaySharingInterface(Seeds.Share.response)

        // Then
        XCTAssertNotNil(sut.presentedViewController,
                        "ProcessedFileViewController should present a sharing interface")
        XCTAssertTrue(sut.presentedViewController is UIActivityViewController,
                      "ProcessedFileViewController should present UIActivityViewController")
        let expectedExcludedActivityTypes = Seeds.Share.response.excludedActivityTypes
        let actualExcludedActivityTypes = (sut.presentedViewController as? UIActivityViewController)?
            .excludedActivityTypes
        XCTAssertEqual(expectedExcludedActivityTypes, actualExcludedActivityTypes,
                       "displaySharingInterface(_:) method should set correct excluded activity types" +
            " for UIActivityViewController")
    }

    func test_ThatProcessedFileViewController_SelectsFiles() {

        // Given
        let processedFileViewControllerOutputSpy = ProcessedFileViewControllerOutputSpy()
        let collectionViewMock = UICollectionViewMock(frame: CGRect.zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
        let cellMock = FileCollectionViewCellMock()

        collectionViewMock.cellMock = cellMock
        sut.output = processedFileViewControllerOutputSpy
        sut.collectionView = collectionViewMock

        // When
        sut.collectionView!.selectItem(at: Seeds.SelectFiles.indexPathToSelect,
                                                  animated: false, scrollPosition: [])
        sut.collectionView(sut.collectionView!, didSelectItemAt: Seeds.SelectFiles.indexPathToSelect)

        // Then
        let expectedSelectedFileIndexPath = Seeds.SelectFiles.indexPathToSelect
        let actualSelectedFileIndexPath = processedFileViewControllerOutputSpy.selectedFileIndexPath
        XCTAssertNotNil(actualSelectedFileIndexPath,
                      "When a cell was selected, ProcessedFileViewController should notify the interactor")
        XCTAssertEqual(expectedSelectedFileIndexPath, actualSelectedFileIndexPath,
                       "ProcessedFileViewController should send the interactor the index path of a selected file")
        XCTAssertTrue(cellMock.visualizeSelection_called,
                      "When a cell was selected, it should visualize its selection")
    }

    func test_ThatProcessedFileViewController_DeselectsFiles() {

        // Given
        let processedFileViewControllerOutputSpy = ProcessedFileViewControllerOutputSpy()
        let collectionViewMock = UICollectionViewMock(frame: CGRect.zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
        let cellMock = FileCollectionViewCellMock()

        collectionViewMock.cellMock = cellMock
        sut.output = processedFileViewControllerOutputSpy
        sut.collectionView = collectionViewMock

        // When
        sut.collectionView!.selectItem(at: Seeds.SelectFiles.indexPathToDeselect,
                                                  animated: false, scrollPosition: [])
        sut.collectionView(sut.collectionView!, didSelectItemAt: Seeds.SelectFiles.indexPathToDeselect)
        sut.collectionView!.deselectItem(at: Seeds.SelectFiles.indexPathToDeselect,
                                                  animated: false)
        sut.collectionView(sut.collectionView!, didDeselectItemAt: Seeds.SelectFiles.indexPathToDeselect)

        // Then
        let expectedDeselectedFileIndexPath = Seeds.SelectFiles.indexPathToDeselect
        let actualDeselectedFileIndexPath = processedFileViewControllerOutputSpy.deselectedFileIndexPath
        XCTAssertNotNil(actualDeselectedFileIndexPath,
                        "When a cell was deselected, ProcessedFileViewController should notify the interactor")
        XCTAssertEqual(expectedDeselectedFileIndexPath, actualDeselectedFileIndexPath,
                       "ProcessedFileViewController should send the interactor the index path of a deselected" +
            " file")
        XCTAssertTrue(cellMock.visualizeDeselection_called,
                      "When a cell was deselected, it should visualize its deselection")
    }
}
// swiftlint:enable force_cast
// swiftlint:enable force_unwrapping
