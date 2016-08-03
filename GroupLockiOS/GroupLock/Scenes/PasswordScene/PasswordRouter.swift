//
//  PasswordRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol PasswordRouterInput {
    func navigateToMainScreen()
}

class PasswordRouter: PasswordRouterInput {

    weak var viewController: PasswordViewController!

    // MARK: - Navigation
    func navigateToMainScreen() {
        viewController.performSegueWithIdentifier("toMainScreen", sender: self)
    }

    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with

        if segue.identifier == "toMainScreen" {

        }
    }
}
