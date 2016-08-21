//
//  CGPoint.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreGraphics

extension CGPoint {

    /**
     Creates a point using the contents of the specified dictionary.

     - parameter cfDictionary: CFDictionary representation of the point
     */
    init(cfDictionary: CFDictionary) {
        var point = CGPoint.zero
        CGPointMakeWithDictionaryRepresentation(cfDictionary, &point)
        self = point
    }
}
