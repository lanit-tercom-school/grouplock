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
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == "encryptFiles" {
            passDataToKeyTypeScene(segue)
        }
    }
    
    func passDataToKeyTypeScene(segue: UIStoryboardSegue) {
        
        let destination = segue.destinationViewController as! KeyTypeViewController
        let conveyedFiles = Array(viewController.selectedFiles.values)
        destination.files = conveyedFiles
    }
}
