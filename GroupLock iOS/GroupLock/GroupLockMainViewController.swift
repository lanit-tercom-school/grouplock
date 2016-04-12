//
//  GroupLockMainViewController.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 12/04/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class GroupLockMainViewController: UIViewController {
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    
    let projectColors = Colors()
    
    override func viewDidLoad() {
        encryptButton.backgroundColor = projectColors.mainColor()
        decryptButton.backgroundColor = projectColors.mainColor()
        encryptButton.tintColor = projectColors.textColor()
        decryptButton.tintColor = projectColors.textColor()
        view.backgroundColor = projectColors.backgroundColor()
        
    }

}
