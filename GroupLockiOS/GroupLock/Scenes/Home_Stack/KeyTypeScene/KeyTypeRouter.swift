//
//  KeyTypeRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol KeyTypeRouterInput {
    func navigateToNumberOfKeysScene()
}

class KeyTypeRouter: KeyTypeRouterInput {

    weak var viewController: KeyTypeViewController!

    // MARK: - Navigation

    func navigateToNumberOfKeysScene() {
        viewController.performSegue(withIdentifier: "NumberOfKeys", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

        if segue.identifier == "NumberOfKeys" {
            passDataToNumberOfKeysScene(segue)
        }
    }

    func passDataToNumberOfKeysScene(_ segue: UIStoryboardSegue) {

        // swiftlint:disable:next force_cast (since the destination is known)
        let numberOfKeysViewController = segue.destination as! NumberOfKeysViewController
        numberOfKeysViewController.output.files = viewController.output.files
    }
}
