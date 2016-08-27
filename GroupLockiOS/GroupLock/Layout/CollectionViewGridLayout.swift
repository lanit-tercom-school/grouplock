//
//  CollectionViewGridLayout.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class CollectionViewGridLayout {

    static let relativeInset = CGFloat(1.0 / 12.0)
    static let minimumLineSpacingFactor = CGFloat(2.0 / 3.0)

    private static func getSectionInset(for collectionView: UICollectionView) -> CGFloat {
        return collectionView.frame.width * relativeInset
    }

    private static func getItemWidth(for collectionView: UICollectionView) -> CGFloat {
        return (collectionView.frame.width - 3 * getSectionInset(for: collectionView)) / 2
    }


    /// Creates a new `UICollectionViewFlowLayout` object with properties specified in the
    /// `CollectionViewGridLayout` class
    static func setCollectionViewFlowLayout(for collectionView: UICollectionView,
                                                withBaseLayout baseLayout: UICollectionViewFlowLayout?) {

        var layout: UICollectionViewFlowLayout

        if baseLayout != nil {
            // swiftlint:disable:next force_unwrapping
            layout = baseLayout!
        } else {
            layout = UICollectionViewFlowLayout()
        }

        let width = getItemWidth(for: collectionView)
        layout.itemSize = CGSize(width: width, height: width)
        let sectionInset = getSectionInset(for: collectionView)
        layout.sectionInset = UIEdgeInsets(top: sectionInset,
                                           left: sectionInset,
                                           bottom: sectionInset,
                                           right: sectionInset)
        layout.minimumLineSpacing = sectionInset * minimumLineSpacingFactor

        collectionView.collectionViewLayout = layout
    }
}
