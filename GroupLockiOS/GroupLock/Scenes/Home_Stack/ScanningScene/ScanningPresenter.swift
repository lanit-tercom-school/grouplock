//
//  ScanningPresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import CoreGraphics

protocol ScanningPresenterInput {
    func formatKeyScan(response: Scanning.Keys.Response)
}

protocol ScanningPresenterOutput: class {
    func displayKeyScan(viewModel: Scanning.Keys.ViewModel)
}

class ScanningPresenter: ScanningPresenterInput {

    weak var output: ScanningPresenterOutput!

    // MARK: - Presentation logic

    func formatKeyScan(response: Scanning.Keys.Response) {
        let numberOfDifferentKeys = response.keys.count
        let qrCodeCGPath = CGPath.create(response.qrCodeCorners.map(CGPoint.init))
        let viewModel = Scanning.Keys.ViewModel(numberOfDifferentKeys: numberOfDifferentKeys,
                                                qrCodeCGPath: qrCodeCGPath,
                                                isNewKey: response.isNewKey)
        output.displayKeyScan(viewModel)
    }
}
