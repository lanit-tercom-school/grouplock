//
//  CGPath.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreGraphics

extension CGPath {

    /**
     Creates a polygonal CGPath from array of CGPoints

     - parameter points: vertices of the polygon

     - returns: Polygonal CGPath
     */
    static func create(points: [CGPoint]) -> CGPath {
        let path = CGPathCreateMutable()
        guard let initialPoint = points.first else { return path }
        CGPathMoveToPoint(path, nil, initialPoint.x, initialPoint.y)
        for point in points {
            CGPathAddLineToPoint(path, nil, point.x, point.y)
        }
        CGPathCloseSubpath(path)
        return path
    }
}
