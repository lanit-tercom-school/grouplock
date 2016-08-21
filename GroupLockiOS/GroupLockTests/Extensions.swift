//
//  Extensions.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

extension NSData: Comparable {}

public func < (lhs: NSData, rhs: NSData) -> Bool {
    return lhs.length < rhs.length
}

public func <= (lhs: NSData, rhs: NSData) -> Bool {
    return lhs.length <= rhs.length
}

extension CGPath: Equatable {}

public func == (lhs: CGPath, rhs: CGPath) -> Bool {

    func draw(path path: CGPath) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 500, height: 500))
        let context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, path)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextStrokePath(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    return draw(path: lhs).isEqualToImage(draw(path: rhs))
}
