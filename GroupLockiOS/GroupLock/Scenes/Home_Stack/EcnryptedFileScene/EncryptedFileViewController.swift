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
    var encryptedFiles: [File]! { get set }
    
    func fetchFiles(request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(request: EncryptedFile.Share.Request)
    func fileSelected(request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(request: EncryptedFile.SelectFiles.Request)
    func saveFiles(request: EncryptedFile.SaveFiles.Request)
}

class EncryptedFileViewController: UICollectionViewController, EncryptedFileViewControllerInput {
    
    var output: EncryptedFileViewControllerOutput!
    var router: EncryptedFileRouter!
    
    var collectionViewDataSource: UICollectionViewDataSource!
    
    // MARK: - View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        output.fetchFiles(EncryptedFile.Fetch.Request())
    }
    
    // MARK: - Display logic
    
    private func configureCollectionView() {
        
        collectionView?.applyNUI()
        collectionView?.allowsMultipleSelection = true
        
        guard let collectionViewLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        CollectionViewGridLayout.setCollectionViewFlowLayout(for: collectionView!,
                                                             withBaseLayout: collectionViewLayout)
    }
    
    func displayFiles(viewModel: EncryptedFile.Fetch.ViewModel) {
        collectionViewDataSource = EncryptedFileDataSource(viewModel: viewModel)
        collectionView?.dataSource = collectionViewDataSource
        collectionView?.reloadData()
    }
    
    func displaySharingInterface(response: EncryptedFile.Share.Response) {
        
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
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FileCollectionViewCell
        
        output.fileSelected(EncryptedFile.SelectFiles.Request(indexPath: indexPath))
        
        cell.visualizeSelection()
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
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
