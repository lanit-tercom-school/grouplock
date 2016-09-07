//
//  ProcessedFileDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProcessedFileDataSourceProtocol: UICollectionViewDataSource {
    func updateViewModel(_ viewModel: ProcessedFile.Fetch.ViewModel)
}

class ProcessedFileDataSource: NSObject, ProcessedFileDataSourceProtocol {

    private var viewModel: ProcessedFile.Fetch.ViewModel!

    var cellProvider: FileCollectionViewCellProviderProtocol =
        FileCollectionViewCellProvider(reuseIdentifier: "ProcessedFileCell")

    func updateViewModel(_ viewModel: ProcessedFile.Fetch.ViewModel) {
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
