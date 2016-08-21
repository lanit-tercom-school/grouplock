//
//  ChooseFileRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ChooseFileRouterInput {
    func navigateToKeyTypeScene()
    func navigateToScanningScene()
}

class ChooseFileRouter: ChooseFileRouterInput {

    weak var viewController: ChooseFileViewController!

    // MARK: - Navigation

    func navigateToKeyTypeScene() {
        viewController.performSegueWithIdentifier("toKeyType", sender: nil)
    }

    func navigateToScanningScene() {
        viewController.performSegueWithIdentifier("toScanning", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {

        if segue.identifier == "toKeyType" {
            passDataToKeyTypeScene(segue)
        } else if segue.identifier == "toScanning" {
            passDataToScanningScene(segue)
        }
    }

    func passDataToKeyTypeScene(segue: UIStoryboardSegue) {
        // swiftlint:disable:next force_cast (since the destination is known)
        let keyTypeViewController = segue.destinationViewController as! KeyTypeViewController
        keyTypeViewController.output.files = viewController.output.chosenFiles
    }

    func passDataToScanningScene(segue: UIStoryboardSegue) {
        // swiftlint:disable:next force_cast (since the destination is known)
//        let scanningViewController = segue.destinationViewController as! ScanningViewController

    }
}
