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

    func passDataToNextScene(segue: UIStoryboardSegue) {

        if segue.identifier == "ProvideKey" {
            passDataToProvideKeyScene(segue)
        }
    }

    func passDataToProvideKeyScene(segue: UIStoryboardSegue) {

        // swiftlint:disable:next force_cast (since the destination is known)
        let provideKeysViewController = segue.destinationViewController as! ProvideKeyViewController
        provideKeysViewController.output.numberOfKeys = (viewController.pickerView.selectedRowInComponent(0) + 1,
                                                         viewController.pickerView.selectedRowInComponent(1) + 1)
        provideKeysViewController.output.files = viewController.output.files
    }
}
