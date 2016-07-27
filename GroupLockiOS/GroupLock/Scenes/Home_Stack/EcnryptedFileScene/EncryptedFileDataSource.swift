//
//  EncryptedFileDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileDataSourceProtocol: UICollectionViewDataSource {
    func updateViewModel(viewModel: EncryptedFile.Fetch.ViewModel)
}

class EncryptedFileDataSource: NSObject, EncryptedFileDataSourceProtocol {
    
    private var viewModel: EncryptedFile.Fetch.ViewModel!
    
    var cellProvider: FileCollectionViewCellProviderProtocol =
        FileCollectionViewCellProvider(reuseIdentifier: "EncryptedFileCell")
    
    func updateViewModel(viewModel: EncryptedFile.Fetch.ViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fileInfo.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = cellProvider.cell(for: collectionView, at: indexPath)
        let fileInfo = viewModel.fileInfo[indexPath.item]
        cell.filenameLabel.text = fileInfo.fileName
        cell.thumbnailView.image = fileInfo.fileThumbnail
        cell.lockIcon.hidden = !fileInfo.encrypted
        
        if cell.selected {
            cell.visualizeSelection()
        } else {
            cell.visualizeDeselection()
        }
        
        return cell
    }
}
