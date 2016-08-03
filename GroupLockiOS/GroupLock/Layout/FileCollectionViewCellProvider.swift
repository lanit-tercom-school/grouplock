//
//  FileCollectionViewCellProvider.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 25.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit


protocol FileCollectionViewCellProviderProtocol {
    init(reuseIdentifier: String)
    func cell(for collectionView: UICollectionView, at indexPath: NSIndexPath) -> FileCollectionViewCell
}

struct FileCollectionViewCellProvider: FileCollectionViewCellProviderProtocol {

    private var reuseIdentifier: String

    init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }

    func cell(for collectionView: UICollectionView, at indexPath: NSIndexPath) -> FileCollectionViewCell {
        return collectionView
            .dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                                                    forIndexPath: indexPath) as! FileCollectionViewCell
        // swiftlint:disable:previous force_cast (since we use FileCollectionViewCellProvider only for
        // collectionViews which cells are instances of this class)
    }
}
