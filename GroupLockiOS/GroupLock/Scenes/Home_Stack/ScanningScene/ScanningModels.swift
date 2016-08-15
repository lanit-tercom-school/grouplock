//
//  ScanningModels.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import CoreGraphics

// MARK: Scene
struct Scanning {

    // MARK: Use Case
    struct Configure {

        struct Request {

        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    // MARK: Use Case
    struct Keys {

        struct Request {

        }

        struct Response {
            var keyScanned: String
            var isNewKey: Bool
            var qrCodeCorners: [CFDictionary]
            var keys: [String]
        }

        struct ViewModel {
            var numberOfDifferentKeys: Int
            var qrCodeCGPath: CGPath
            var isNewKey: Bool
        }
    }
}
