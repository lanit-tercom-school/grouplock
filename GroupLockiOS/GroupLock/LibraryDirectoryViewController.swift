//
//  LibraryDirectoryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 14.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class LibraryDirectoryViewController: UIViewController {
    
    @IBOutlet var encryptedButton: UIButton!
    @IBOutlet var decryptedButton: UIButton!
    @IBOutlet var loadButton: UIButton!
    
    let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
    
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
            destination.directory = directory
        }
    }
}

extension LibraryDirectoryViewController {
    
    @IBAction func onLoad(sender: UIButton) {
        
        presentImagePicker()
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let fileURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        
        if let loadedFile = FileManager.sharedInstance.createFileFromURL(fileURL, withName: "__defaultName", encrypted: false) {
            pickEncryptionStatusAlert(forFile: loadedFile, completion: { (file) in
                self.setFileNameAlert(file, completion: { (file) in
                    self.managedObjectContext.insertObject(file)
                    AppDelegate.sharedInstance.saveContext()
                })
            })
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}