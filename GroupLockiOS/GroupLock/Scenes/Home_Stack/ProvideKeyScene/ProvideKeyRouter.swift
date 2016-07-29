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
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        
    }
}
