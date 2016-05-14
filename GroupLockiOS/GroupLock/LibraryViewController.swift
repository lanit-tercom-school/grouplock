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
    var files = [File]()
    
    let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
    
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
        albumPicker.navigationBar.translucent = false
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
        
        loadedFile.contents = fileContents
        loadedFile.type = fileType
        
        pickEncryptionStatus(forFile: loadedFile, completion: setFileName)
        
    }
    
    func pickEncryptionStatus(forFile file: File, completion: ((File) -> Void)?) {
        let actionSheet = UIAlertController(title: nil, message: "What do you to load this file for?",
                                            preferredStyle: .ActionSheet)
        let forEncryption = UIAlertAction(title: "Encryption", style: .Default) { _ in
            file.encrypted = false
            completion?(file)
        }
        let forDecryption = UIAlertAction(title: "Decryption", style: .Default) { _ in
            file.encrypted = true
            completion?(file)
        }
        actionSheet.addAction(forEncryption)
        actionSheet.addAction(forDecryption)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setFileName(file: File) -> Void {
        let nameAlert = UIAlertController(title: "Name", message: "Type a desired name for this file.",
                                          preferredStyle: .Alert)
        nameAlert.addTextFieldWithConfigurationHandler(nil)
        
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            if let name = nameAlert.textFields?.first?.text {
                file.name = name
                self.managedObjectContext.insertObject(file)
                AppDelegate.sharedInstance.saveContext()
                self.tableView.reloadData()
            }
        }
        
        nameAlert.addAction(action)
        
        presentViewController(nameAlert, animated: false, completion: nil)
    }
}