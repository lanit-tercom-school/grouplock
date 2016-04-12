//
//  TabBarController.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 12/04/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: UI elements
    let projectColors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = projectColors.mainColor()
        
    }
    
}