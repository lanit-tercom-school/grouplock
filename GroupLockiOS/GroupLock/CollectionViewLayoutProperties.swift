//
//  CollectionViewLayoutProperties.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

struct CollectionViewLayoutProperties {
    
    static let relativeInset = CGFloat(1.0 / 12.0)
    static let minimumLineSpacingFactor = CGFloat(2.0 / 3.0)
    
    static func getSectionInset(forCollectionView collectionView: UICollectionView) -> CGFloat {
        return collectionView.frame.width * relativeInset
    }
    
    static func getItemWidth(forCollectionView collectionView: UICollectionView) -> CGFloat {
        return (collectionView.frame.width - 3*getSectionInset(forCollectionView: collectionView)) / 2
    }
}