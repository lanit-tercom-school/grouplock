//
//  KeyTypeInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

protocol KeyTypeInteractorInput {
    var files: [File]! { get set }
    var keyType: KeyType { get }
    
    func setKeyType(request: KeyTypeModels.SetType.Request)
}

protocol KeyTypeInteractorOutput {
    
}

class KeyTypeInteractor: KeyTypeInteractorInput {
    
    var output: KeyTypeInteractorOutput!
    
    // MARK: - Business logic
    
    var files: [File]!
    var keyType: KeyType = .QRCode
    
    func setKeyType(request: KeyTypeModels.SetType.Request) {
        
        switch request.keyName  {
        case KeyType.QRCode.rawValue:
            keyType = .QRCode
        default:
            break
        }
    }
}
