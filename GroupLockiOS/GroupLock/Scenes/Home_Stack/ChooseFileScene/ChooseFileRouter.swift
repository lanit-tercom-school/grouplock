//
//  ChooseFileRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ChooseFileRouterInput {

}

class ChooseFileRouter: ChooseFileRouterInput {

    weak var viewController: ChooseFileViewController!

    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {

        if segue.identifier == "toKeyType" {
            passDataToKeyTypeScene(segue)
        }
    }

    func passDataToKeyTypeScene(segue: UIStoryboardSegue) {
        // swiftlint:disable:next force_cast (since the destination is known)
        let keyTypeViewController = segue.destinationViewController as! KeyTypeViewController
        keyTypeViewController.output.files = viewController.output.chosenFiles
    }
}
