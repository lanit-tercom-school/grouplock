//
//  EncryptedFileViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileViewControllerInput {
    func displayFiles(_ viewModel: EncryptedFile.Fetch.ViewModel)
    func displaySharingInterface(_ response: EncryptedFile.Share.Response)
}

protocol EncryptedFileViewControllerOutput {
    var files: [File] { get set }
    var encryptedFiles: [File] { get }
    var encryptionKey: [String] { get set }

    func encryptFiles(_ request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(_ request: EncryptedFile.Share.Request)
    func fileSelected(_ request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(_ request: EncryptedFile.SelectFiles.Request)
    func saveFiles(_ request: EncryptedFile.SaveFiles.Request)
}

class EncryptedFileViewController: UICollectionViewController, EncryptedFileViewControllerInput {

    var output: EncryptedFileViewControllerOutput!
    var router: EncryptedFileRouter!

    var collectionViewDataSource: EncryptedFileDataSourceProtocol = EncryptedFileDataSource()
    var collectionViewConfigurator: CollectionViewConfiguratorProtocol = CollectionViewConfigurator()

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint:disable:next force_unwrapping (when this method is invoked collectionView is initialized)
        collectionViewConfigurator.configure(collectionView!, allowsMultipleSelection: true)

        output.encryptFiles(EncryptedFile.Fetch.Request())
    }

    // MARK: - Display logic

    func displayFiles(_ viewModel: EncryptedFile.Fetch.ViewModel) {

        collectionViewDataSource.updateViewModel(viewModel)

        // swiftlint:disable force_unwrapping (when this method is invoked collectionView is initialized)
        collectionView!.dataSource = collectionViewDataSource
        collectionView!.reloadData()
        // swiftlint:enable force_unwrapping

        activityIndicator.stopAnimating()
    }

    func displaySharingInterface(_ response: EncryptedFile.Share.Response) {
        // TODO: Disable Share button if no files were selected
        let activityViewController = UIActivityViewController(activityItems: response.dataToShare,
                                                              applicationActivities: nil)

        activityViewController.excludedActivityTypes = response.excludedActivityTypes

        present(activityViewController, animated: true, completion: nil)
    }

    // MARK: - Event Handling

    @IBAction func onShareButton(_ sender: UIBarButtonItem) {
        output.prepareFilesForSharing(EncryptedFile.Share.Request())
    }

    @IBAction func onSaveButton(_ sender: UIBarButtonItem) {
        output.saveFiles(EncryptedFile.SaveFiles.Request())
        router.returnToHomeScene()
    }
}

extension EncryptedFileViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItem(at: indexPath) as! FileCollectionViewCell

        output.fileSelected(EncryptedFile.SelectFiles.Request(indexPath: indexPath))

        cell.visualizeSelection()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didDeselectItemAt indexPath: IndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItem(at: indexPath) as! FileCollectionViewCell

        output.fileDeselected(EncryptedFile.SelectFiles.Request(indexPath: indexPath))

        cell.visualizeDeselection()
    }
}

extension EncryptedFileViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        EncryptedFileConfigurator.configure(self)
    }
}
