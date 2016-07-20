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
        
        var uiImageQRCodes = [UIImage]()
        
        for key in keys {
            // TODO: Вынести в отдельный класс
            let data = key.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return }
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            
            guard let ciImageQRCode = filter.outputImage else { return }
            
            let scaleX = 1080 / ciImageQRCode.extent.width
            let scaleY = 1080 / ciImageQRCode.extent.height
            
            let transformedImage = ciImageQRCode.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))

            uiImageQRCodes.append(UIImage(CIImage: transformedImage))
            
            // TODO: – Переделать всё с учетом разного масштаба изображений QR-кодов. На данный момент в массив помещаются изображения фиксированного размера (1080x1080)
        }
        
        let viewModel = ProvideKey.Configure.ViewModel(qrCodes: uiImageQRCodes)
        
        output.displayKeys(with: viewModel)
    }
}
