//
//  EncryptedFileDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class EncryptedFileDataSource: NSObject, UICollectionViewDataSource {
    
    private var viewModel: EncryptedFile.Fetch.ViewModel
    
    init(viewModel: EncryptedFile.Fetch.ViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fileInfo.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCellWithReuseIdentifier("EncryptedFileCell",
                                                    forIndexPath: indexPath) as! FileCollectionViewCell
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
