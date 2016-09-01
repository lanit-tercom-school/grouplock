//
//  ScanningRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ScanningRouterInput {
    func navigateBackToChooseFile()
}

class ScanningRouter: ScanningRouterInput {

    weak var viewController: ScanningViewController!

    // MARK: - Navigation

    func navigateBackToChooseFile() {
        _ = viewController.navigationController?.popViewController(animated: true)
    }

    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

        if segue.identifier == "ProcessedFile" {
            passDataToProcessedFileScene(segue)
        }
    }

    func passDataToProcessedFileScene(_ segue: UIStoryboardSegue) {

        // swiftlint:disable:next force_cast (since the destination is known)
        let processedFileViewController = segue.destination as! ProcessedFileViewController
        processedFileViewController.output.files = viewController.output.files
        processedFileViewController.output.cryptographicKey = viewController.output.scannedKeys
        processedFileViewController.output.isEncryption = false
    }
}
