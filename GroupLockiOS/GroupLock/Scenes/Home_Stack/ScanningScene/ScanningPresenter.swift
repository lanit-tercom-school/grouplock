//
//  ScanningPresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import CoreGraphics

protocol ScanningPresenterInput {
    func formatKeyScan(_ response: Scanning.Keys.Response)
    func formatCameraError(_ response: Scanning.CameraError.Response)
}

protocol ScanningPresenterOutput: class {
    func displayKeyScan(_ viewModel: Scanning.Keys.ViewModel)
    func displayCameraErrorMessage(_ viewModel: Scanning.CameraError.ViewModel)
}

class ScanningPresenter: ScanningPresenterInput {

    weak var output: ScanningPresenterOutput!

    // MARK: - Presentation logic

    func formatKeyScan(_ response: Scanning.Keys.Response) {
        let numberOfDifferentKeys = response.keys.count

        let qrCodeCGPath = CGPath.create(response.qrCodeCorners.map { CGPoint(dictionaryRepresentation: $0)! })
        let viewModel = Scanning.Keys.ViewModel(numberOfDifferentKeys: numberOfDifferentKeys,
                                                qrCodeCGPath: qrCodeCGPath,
                                                isValidKey: response.isValidKey)
        output.displayKeyScan(viewModel)
    }

    func formatCameraError(_ response: Scanning.CameraError.Response) {

        let errorDescription = response.error.localizedDescription

        // swiftlint:disable:next force_unwrapping (since description is never empty)
        let formattedDescription = String(errorDescription.characters.first!).uppercased() +
            String(errorDescription.characters.dropFirst()).lowercased() + "."

        let viewModel = Scanning.CameraError.ViewModel(errorName: "Camera Error",
                                                       errorDescription: formattedDescription)
        output.displayCameraErrorMessage(viewModel)
    }
}
