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
        viewController.performSegueWithIdentifier("NumberOfKeys", sender: nil)
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        
        if segue.identifier == "NumberOfKeys" {
            passDataToNumberOfKeysScene(segue)
        }
    }
    
    func passDataToNumberOfKeysScene(segue: UIStoryboardSegue) {
        
        let numberOfKeysViewController = segue.destinationViewController as! NumberOfKeysViewController
        
    }
}
