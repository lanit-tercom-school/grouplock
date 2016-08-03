//
//  EncryptedFileRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileRouterInput {
    func returnToHomeScene()
}

class EncryptedFileRouter: EncryptedFileRouterInput {

    weak var viewController: EncryptedFileViewController!

    // MARK: - Navigation

    func returnToHomeScene() {
        viewController.performSegueWithIdentifier("ReturnToHomeScreen", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {

    }

}
