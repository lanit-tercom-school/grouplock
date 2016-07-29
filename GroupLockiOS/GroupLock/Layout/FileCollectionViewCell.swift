//
//  FileCollectionViewCell.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import NUI

class FileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var filenameLabel: UILabel!
    @IBOutlet var lockIcon: UIImageView!
    
    func visualizeSelection() {
        layer.borderWidth = CGFloat(NUISettings.getFloat("selected-border-width",
            withClass: "CollectionViewCell"))
    }
    
    func visualizeDeselection() {
        layer.borderWidth = 0
    }
}
