//
//  LibraryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class LibraryViewController: UITableViewController {
    
    
    /// Current list of files displayed on the screen
    private var files = [File]()
    
    let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
    let managedObjectModel = AppDelegate.sharedInstance.managedObjectModel
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("fileCell",
                                                               forIndexPath: indexPath) as! FileTableViewCell
        cell.title.text = files[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}

extension LibraryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func onLoad(sender: UIBarButtonItem) {
        
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        presentViewController(albumPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let fileURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let fileType = info[UIImagePickerControllerMediaType] as! String
        print(fileURL)
        let fileContents = NSData(contentsOfURL: fileURL)
        
        let fileEntity = NSEntityDescription.entityForName("File", inManagedObjectContext: managedObjectContext)
        let loadedFile = File(entity: fileEntity!, insertIntoManagedObjectContext: nil)
        
        pickEncryptionStatus(forFile: loadedFile)
        
    }
    
    func pickEncryptionStatus(forFile file: File) {
        let actionSheet = UIAlertController(title: nil, message: "What do you to load this file for?",
                                            preferredStyle: .ActionSheet)
        let forEncryption = UIAlertAction(title: "Encryption", style: .Default) { _ in
            self.setEnctyptionStatus(forFile: file, encrypted: false)
            self.setFileName(file)
        }
        let forDecryption = UIAlertAction(title: "Decryption", style: .Default) { _ in
            self.setEnctyptionStatus(forFile: file, encrypted: true)
            self.setFileName(file)
        }
        actionSheet.addAction(forEncryption)
        actionSheet.addAction(forDecryption)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func setEnctyptionStatus(forFile file: File, encrypted status: Bool) {
        file.encrypted = status
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setFileName(file: File) {
        let nameAlert = UIAlertController(title: "Name", message: "Type a desired name for this file.",
                                          preferredStyle: .Alert)
        nameAlert.addTextFieldWithConfigurationHandler(nil)
        nameAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(nameAlert, animated: false, completion: nil)
    }
}
