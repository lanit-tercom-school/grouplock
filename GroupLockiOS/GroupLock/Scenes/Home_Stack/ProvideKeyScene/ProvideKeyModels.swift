//
//  ProvideKeyModels.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: Scene
struct ProvideKey {
    
    // MARK: Use Case
    struct Configure {
        
        struct Request {
            
        }
        
        struct Response {
            var decryptionKeys: [String]
        }
        
        struct ViewModel {
            var qrCode: UIImage
        }
    }
}
