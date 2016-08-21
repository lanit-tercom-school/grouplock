//
//  HomeViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var encryptButton: UIButton!
    @IBOutlet var decryptButton: UIButton!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)

        if let destination = segue.destinationViewController as? ChooseFileViewController {
            destination.output.encryption = sender === encryptButton
        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
}
