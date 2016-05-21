//
//  HomeViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    
    @IBAction func onEncrypt() {
        performSegueWithIdentifier("chooseFileToEncrypt", sender: encryptButton)
    }
    @IBAction func onDecrypt() {

    }
}
