//
//  ProvideKeyPresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProvideKeyPresenterInput {
    func createQRCodes(response: ProvideKey.Configure.Response)
}

protocol ProvideKeyPresenterOutput: class {
    func displayKeys(with viewModel: ProvideKey.Configure.ViewModel)
}

class ProvideKeyPresenter: ProvideKeyPresenterInput {
    
    weak var output: ProvideKeyPresenterOutput!
    
    // MARK: - Presentation logic
    
    func createQRCodes(response: ProvideKey.Configure.Response) {
        
        let keys = response.decryptionKeys
        
        // ...
        
        
        let uiImageQRCodes = [
            UIImage()
        ]
        
        let viewModel = ProvideKey.Configure.ViewModel(qrCodes: uiImageQRCodes)
        
        output.displayKeys(with: viewModel)
    }
}
