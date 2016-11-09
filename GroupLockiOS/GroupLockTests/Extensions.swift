//
//  Extensions.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

extension Data: Comparable {

    public static func < (lhs: Data, rhs: Data) -> Bool {
        return lhs.count < rhs.count
    }

    static public func <= (lhs: Data, rhs: Data) -> Bool {
        return lhs.count <= rhs.count
    }
}
