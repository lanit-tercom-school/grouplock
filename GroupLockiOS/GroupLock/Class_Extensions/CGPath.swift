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
    static func create(_ points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        guard let initialPoint = points.first else { return path }
        path.move(to: initialPoint)
        for point in points {
            path.addLine(to: point)
        }
        path.closeSubpath()
        return path
    }
}
