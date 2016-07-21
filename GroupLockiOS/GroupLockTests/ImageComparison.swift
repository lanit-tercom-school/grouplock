//
//  ImageComparison.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     Performs UIImage comparison pixel-by-pixel.
     
     - parameter image: Image to compare with.
     
     - returns: `true` iff pixel data of `image` is the same as the receiver's pixel data.
     */
    func isEqualToImage(image: UIImage) -> Bool {
        let data  = image.normilizedData
        let originalData = self.normilizedData
        return originalData == data
    }
    
    private var normilizedData: NSData {
        let sizeInPixels = CGSize(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContext(sizeInPixels)
        drawInRect(CGRect(x: 0, y: 0, width: sizeInPixels.width, height: sizeInPixels.height))
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImagePNGRepresentation(drawnImage)!
    }
}

extension CGImage {
    
    /**
     Performs CGImage comparison pixel-by-pixel using UIImage. Quick and not very universal way, suitable for
     testing purposes only.
     
     - parameter image: Image to compare with.
     
     - returns: `true` iff pixel data of `image` is the same as the receiver's pixel data.
     */
    func isEqualToImage(image: CGImage) -> Bool {
        return UIImage(CGImage: self).isEqualToImage(UIImage(CGImage: image))
    }
}