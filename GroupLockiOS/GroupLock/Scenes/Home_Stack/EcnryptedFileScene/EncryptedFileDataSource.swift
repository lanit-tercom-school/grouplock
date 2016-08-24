//
//  EncryptedFileDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileDataSourceProtocol: UICollectionViewDataSource {
    func updateViewModel(_ viewModel: EncryptedFile.Fetch.ViewModel)
}

class EncryptedFileDataSource: NSObject, EncryptedFileDataSourceProtocol {

    private var viewModel: EncryptedFile.Fetch.ViewModel!

    var cellProvider: FileCollectionViewCellProviderProtocol =
        FileCollectionViewCellProvider(reuseIdentifier: "EncryptedFileCell")

    func updateViewModel(_ viewModel: EncryptedFile.Fetch.ViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fileInfo.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider.cell(for: collectionView, at: indexPath)
        let fileInfo = viewModel.fileInfo[(indexPath as NSIndexPath).item]
        cell.filenameLabel.text = fileInfo.fileName
        cell.thumbnailView.image = fileInfo.fileThumbnail
        cell.lockIcon.isHidden = !fileInfo.encrypted

        if cell.isSelected {
            cell.visualizeSelection()
        } else {
            cell.visualizeDeselection()
        }

        return cell
    }
}
