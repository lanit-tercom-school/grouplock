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
        viewController.performSegue(withIdentifier: "toKeyType", sender: nil)
    }

    func navigateToScanningScene() {
        viewController.performSegue(withIdentifier: "toScanning", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

        if segue.identifier == "toKeyType" {
            passDataToKeyTypeScene(segue)
        } else if segue.identifier == "toScanning" {
            passDataToScanningScene(segue)
        }
    }

    func passDataToKeyTypeScene(_ segue: UIStoryboardSegue) {
        // swiftlint:disable:next force_cast (since the destination is known)
        let keyTypeViewController = segue.destination as! KeyTypeViewController
        keyTypeViewController.output.files = viewController.output.chosenFiles
    }

    func passDataToScanningScene(_ segue: UIStoryboardSegue) {
        // swiftlint:disable:next force_cast (since the destination is known)
//        let scanningViewController = segue.destinationViewController as! ScanningViewController

    }
}
