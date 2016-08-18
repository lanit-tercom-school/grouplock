//
//  ScanningModelsComparison.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

@testable import GroupLock

extension Scanning.Keys.ViewModel: EquatableModel {

    func isEqualTo(model: Scanning.Keys.ViewModel) -> Bool {
        return numberOfDifferentKeys == model.numberOfDifferentKeys &&
            qrCodeCGPath == model.qrCodeCGPath &&
            isValidKey == model.isValidKey
    }
}

extension Scanning.CameraError.ViewModel: EquatableModel {

    func isEqualTo(model: Scanning.CameraError.ViewModel) -> Bool {
        return errorName == model.errorName &&
            errorDescription == model.errorDescription
    }
}
