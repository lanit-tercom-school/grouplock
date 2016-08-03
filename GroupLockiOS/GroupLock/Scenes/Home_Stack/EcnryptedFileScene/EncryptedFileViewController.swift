//
//  EncryptedFileViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileViewControllerInput {
    func displayFiles(viewModel: EncryptedFile.Fetch.ViewModel)
    func displaySharingInterface(response: EncryptedFile.Share.Response)
}

protocol EncryptedFileViewControllerOutput {
    var encryptedFiles: [File] { get set }

    func fetchFiles(request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(request: EncryptedFile.Share.Request)
    func fileSelected(request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(request: EncryptedFile.SelectFiles.Request)
    func saveFiles(request: EncryptedFile.SaveFiles.Request)
}

class EncryptedFileViewController: UICollectionViewController, EncryptedFileViewControllerInput {

    var output: EncryptedFileViewControllerOutput!
    var router: EncryptedFileRouter!

    var collectionViewDataSource: EncryptedFileDataSourceProtocol = EncryptedFileDataSource()
    var collectionViewConfigurator: CollectionViewConfigurator = FileCollectionViewConfigurator()

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint:disable:next force_unwrapping (when this method is invoked collectionView is initialized)
        collectionViewConfigurator.configure(collectionView!, allowsMultipleSelection: true)
        output.fetchFiles(EncryptedFile.Fetch.Request())
    }

    // MARK: - Display logic

    func displayFiles(viewModel: EncryptedFile.Fetch.ViewModel) {
        collectionViewDataSource.updateViewModel(viewModel)
        // swiftlint:disable force_unwrapping (when this method is invoked collectionView is initialized)
        collectionView!.dataSource = collectionViewDataSource
        collectionView!.reloadData()
        // swiftlint:enable force_unwrapping
    }

    func displaySharingInterface(response: EncryptedFile.Share.Response) {
        // TODO: Disable Share button if no files were selected
        let activityViewController = UIActivityViewController(activityItems: response.dataToShare,
                                                              applicationActivities: nil)

        activityViewController.excludedActivityTypes = response.excludedActivityTypes

        presentViewController(activityViewController, animated: true, completion: nil)
    }

    // MARK: - Event Handling

    @IBAction func onShareButton(sender: UIBarButtonItem) {
        output.prepareFilesForSharing(EncryptedFile.Share.Request())
    }

    @IBAction func onSaveButton(sender: UIBarButtonItem) {
        output.saveFiles(EncryptedFile.SaveFiles.Request())
        router.returnToHomeScene()
    }
}

extension EncryptedFileViewController {

    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FileCollectionViewCell

        output.fileSelected(EncryptedFile.SelectFiles.Request(indexPath: indexPath))

        cell.visualizeSelection()
    }

    override func collectionView(collectionView: UICollectionView,
                                 didDeselectItemAtIndexPath indexPath: NSIndexPath) {

        // swiftlint:disable:next force_cast (since this collectionView uses instances of this class as cells)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FileCollectionViewCell

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
