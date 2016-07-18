//
//  ProvideKeyInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

protocol ProvideKeyInteractorInput {
    func getKeys(request: ProvideKey.Configure.Request)
}

protocol ProvideKeyInteractorOutput {
    func createQRCodes(response: ProvideKey.Configure.Response)
}

class ProvideKeyInteractor: ProvideKeyInteractorInput {
    
    var output: ProvideKeyInteractorOutput!
    
    // MARK: - Business logic
    
    var numberOfKeys = (1, 1)
    
    func getKeys(request: ProvideKey.Configure.Request) {
        
        let keys = EncryptionKeyProvider.getKeys(min: numberOfKeys.0, max: numberOfKeys.1)
        
        let response = ProvideKey.Configure.Response(encryptionKeys: keys)
        
        output.createQRCodes(response)
    }
}
