//
//  NumberOfKeysRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol NumberOfKeysRouterInput {

}

class NumberOfKeysRouter: NumberOfKeysRouterInput {

    weak var viewController: NumberOfKeysViewController!

    // MARK: - Navigation

    // MARK: - Communication

    func passDataToNextScene(_ segue: UIStoryboardSegue) {

        if segue.identifier == "ProvideKey" {
            passDataToProvideKeyScene(segue)
        }
    }

    func passDataToProvideKeyScene(_ segue: UIStoryboardSegue) {

        // swiftlint:disable:next force_cast (since the destination is known)
        let provideKeysViewController = segue.destination as! ProvideKeyViewController
        provideKeysViewController.output.numberOfKeys = (viewController.pickerView.selectedRow(inComponent: 0) + 1,
                                                         viewController.pickerView.selectedRow(inComponent: 1) + 1)
        provideKeysViewController.output.files = viewController.output.files
    }
}
