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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let destination = segue.destination as? ChooseFileViewController {
            destination.output.encryption = (sender as? UIButton)  === encryptButton
        }
    }

    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {}
}
