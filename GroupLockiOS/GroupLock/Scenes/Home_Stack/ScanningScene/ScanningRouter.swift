//
//  ScanningRouter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ScanningRouterInput {

}

class ScanningRouter: ScanningRouterInput {

    weak var viewController: ScanningViewController!

    // MARK: - Navigation



    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {

        if segue.identifier == "" {

        }
    }
}
