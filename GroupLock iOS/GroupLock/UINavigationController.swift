//
//  Colors.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 12/04/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // MARK: UI elements
    override public func viewDidLoad() {
        super.viewDidLoad()
        let projectColors = Colors()
        navigationBar.barTintColor = projectColors.mainColor()
        navigationBar.tintColor = projectColors.textColor()
        navigationBar.backgroundColor = projectColors.mainColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: projectColors.textColor()]
        navigationBar.translucent = false
        
    }
    
}
