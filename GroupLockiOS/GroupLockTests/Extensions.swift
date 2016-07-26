//
//  Extensions.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

extension NSData: Comparable {}

public func <(lhs: NSData, rhs: NSData) -> Bool {
    return lhs.length < rhs.length
}

public func <=(lhs: NSData, rhs: NSData) -> Bool {
    return lhs.length <= rhs.length
}
