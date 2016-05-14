//
//  LibraryDirectoryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 14.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class LibraryDirectoryViewController: UIViewController {

    @IBOutlet var encryptedButton: UIButton!
    @IBOutlet var decryptedButton: UIButton!
    @IBOutlet var loadButton: UIButton!
    
    @IBAction func onDirectory(sender: UIButton) {
        performSegueWithIdentifier("toFiles", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sender = sender as? UIButton, let destination = segue.destinationViewController as? LibraryViewController {
            var directory: Directory
            switch sender {
            case encryptedButton:
                directory = .Encrypted
            case decryptedButton:
                directory = .Decrypted
            default:
                directory = .Encrypted
            }
            destination.files = FileManager.sharedInstance.files(insideDirectory: directory)
            destination.navigationItem.title = directory.rawValue
        }
    }
}

extension LibraryDirectoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}