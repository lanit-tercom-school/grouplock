//
//  ProcessedFileViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProcessedFileViewControllerInput {
    func displayFiles(_ viewModel: ProcessedFile.Fetch.ViewModel)
    func displaySharingInterface(_ response: ProcessedFile.Share.Response)
}

protocol ProcessedFileViewControllerOutput {
    var files: [File] { get set }
    var processedFiles: [File] { get }
    var encryptionKey: [String] { get set }

    func encryptFiles(_ request: ProcessedFile.Fetch.Request)
    func prepareFilesForSharing(_ request: ProcessedFile.Share.Request)
    func fileSelected(_ request: ProcessedFile.SelectFiles.Request)
    func fileDeselected(_ request: ProcessedFile.SelectFiles.Request)
    func saveFiles(_ request: ProcessedFile.SaveFiles.Request)
}

class ProcessedFileViewController: UICollectionViewController, ProcessedFileViewControllerInput {

    var output: ProcessedFileViewControllerOutput!
    var router: ProcessedFileRouter!

    var collectionViewDataSource: ProcessedFileDataSourceProtocol = ProcessedFileDataSource()
    var collectionViewConfigurator: CollectionViewConfiguratorProtocol = CollectionViewConfigurator()

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint:disable:next force_unwrapping (when this method is invoked collectionView is initialized)
        collectionViewConfigurator.configure(collectionView!, allowsMultipleSelection: true)

        output.encryptFiles(ProcessedFile.Fetch.Request())
    }

    // MARK: - Display logic

    func displayFiles(_ viewModel: ProcessedFile.Fetch.ViewModel) {

        collectionViewDataSource.updateViewModel(viewModel)

        // swiftlint:disable force_unwrapping (when this method is invoked collectionView is initialized)
        collectionView!.dataSource = collectionViewDataSource
        collectionView!.reloadData()
        // swiftlint:enable force_unwrapping

        activityIndicator.stopAnimating()
    }

    func displaySharingInterface(_ response: ProcessedFile.Share.Response) {
        // TODO: Disable Share button if no files were selected
        let activityViewController = UIActivityViewController(activityItems: response.dataToShare,
                                                              applicationActivities: nil)

        activityViewController.excludedActivityTypes = response.excludedActivityTypes

        present(activityViewController, animated: true, completion: nil)
    }

    // MARK: - Event Handling

    @IBAction func onShareButton(_ sender: UIBarButtonItem) {
        output.prepareFilesForSharing(ProcessedFile.Share.Request())
    }

    @IBAction func onSaveButton(_ sender: UIBarButtonItem) {
        output.saveFiles(ProcessedFile.SaveFiles.Request())
        router.returnToHomeScene()
    }
}

extension ProcessedFileViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItem(at: indexPath) as! FileCollectionViewCell

        output.fileSelected(ProcessedFile.SelectFiles.Request(indexPath: indexPath))

        cell.visualizeSelection()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didDeselectItemAt indexPath: IndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItem(at: indexPath) as! FileCollectionViewCell

        output.fileDeselected(ProcessedFile.SelectFiles.Request(indexPath: indexPath))

        cell.visualizeDeselection()
    }
}

extension ProcessedFileViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ProcessedFileConfigurator.configure(self)
    }
}
