//
//  KeyType.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

enum KeyType: String {
    case QRCode = "QR-CODE"

    // ???: Presence of only one case causes crash. Bug in Swift?
    case Dummy = "Dummy"
}
