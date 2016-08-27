//
//  ProvideKeyRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProvideKeyRouterInput {

}

class ProvideKeyRouter: ProvideKeyRouterInput {

    weak var viewController: ProvideKeyViewController!

    // MARK: - Navigation



    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

        if segue.identifier == "EncryptedFile" {
            passDataToEncryptedFileScene(segue)
        }
    }

    func passDataToEncryptedFileScene(_ segue: UIStoryboardSegue) {

        // swiftlint:disable:next force_cast (since the destination is known)
        let encryptedFileViewController = segue.destination as! EncryptedFileViewController
        encryptedFileViewController.output.files = viewController.output.files
        encryptedFileViewController.output.encryptionKey = viewController.output.keys
    }
}
