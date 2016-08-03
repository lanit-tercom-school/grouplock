//
//  FileCollectionViewConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

/**
 *  Manages layout configuration for a collection view object
 */
protocol CollectionViewConfigurator {

    /**
     Applies specified settings to a given collection view.

     - parameter collectionView:          View to apply settings to.
     - parameter allowsMultipleSelection: Specifies whether multiple cells can be selected.
     */
    func configure(collectionView: UICollectionView, allowsMultipleSelection: Bool)
}

struct FileCollectionViewConfigurator: CollectionViewConfigurator {

    func configure(collectionView: UICollectionView, allowsMultipleSelection: Bool = false) {
        collectionView.applyNUI()
        collectionView.allowsMultipleSelection = allowsMultipleSelection

        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        CollectionViewGridLayout.setCollectionViewFlowLayout(for: collectionView,
                                                             withBaseLayout: collectionViewLayout)
    }
}
