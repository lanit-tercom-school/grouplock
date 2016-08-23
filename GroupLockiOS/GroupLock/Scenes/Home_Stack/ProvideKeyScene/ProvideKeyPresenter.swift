//
//  ProvideKeyPresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProvideKeyPresenterInput {
    func createQRCodes(_ response: ProvideKey.Configure.Response)
}

protocol ProvideKeyPresenterOutput: class {
    func displayKeys(_ viewModel: ProvideKey.Configure.ViewModel)
}

class ProvideKeyPresenter: ProvideKeyPresenterInput {

    weak var output: ProvideKeyPresenterOutput!

    // MARK: - Presentation logic

    func createQRCodes(_ response: ProvideKey.Configure.Response) {

        let keys = response.decryptionKeys

        let screenSize = UIScreen.main.nativeBounds.size
        let screenWidth = min(screenSize.width, screenSize.height)

        let uiImageQRCodes = keys.map {
            return QRCode(string: $0)?.createUIImage(width: screenWidth) ?? UIImage()
        }

        let viewModel = ProvideKey.Configure.ViewModel(qrCodes: uiImageQRCodes)

        output.displayKeys(viewModel)
    }
}
