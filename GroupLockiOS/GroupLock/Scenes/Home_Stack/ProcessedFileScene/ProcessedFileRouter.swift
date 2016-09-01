//
//  ProcessedFileRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProcessedFileRouterInput {
    func returnToHomeScene()
}

class ProcessedFileRouter: ProcessedFileRouterInput {

    weak var viewController: ProcessedFileViewController!

    // MARK: - Navigation

    func returnToHomeScene() {
        viewController.performSegue(withIdentifier: "ReturnToHomeScreen", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

    }

}
