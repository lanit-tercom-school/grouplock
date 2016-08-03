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

    /// Current directory's contents displayed
    var directory = Directory.Encrypted

    /// Current list of files displayed on the screen
    private var files: [ManagedFile] {
        // FIXME: This causes a lag when entering this screen.
        // This property must be stored and has to be set in the background.
        return FileManager.sharedInstance.files(insideDirectory: directory)
    }

    private let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = directory.rawValue
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

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
        // swiftlint:disable:previous force_cast (since this tableView uses instances of this class as cells)

        cell.correspondingFile = files[indexPath.row]
        cell.title.text = files[indexPath.row].name
        cell.type.text = files[indexPath.row].type


        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {

    }

    // MARK: - Loading a new file using UIImagePickerController

    @IBAction func onLoad(sender: UIBarButtonItem) {

        presentImagePicker()
    }

    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)

        // swiftlint:disable:next force_cast (since the value for this key contains an instance of NSURL)
        let fileURL = info[UIImagePickerControllerReferenceURL] as! NSURL

        // Create a new file with some default settings
        if let loadedFile = FileManager.sharedInstance.createFileFromURL(fileURL, withName: "__defaultName",
                                                                         encrypted: false) {

            // Depending on which direcrory we're in, put the file into it
            switch directory {
            case .Decrypted:
                loadedFile.encrypted = false
            case .Encrypted:
                loadedFile.encrypted = true
            }
            setFileNameAlert(loadedFile) { (file) in
                self.managedObjectContext.insertObject(file)
                AppDelegate.sharedInstance.saveContext()
                self.tableView.reloadData()
            }
        }

    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewFile" {
            guard let cell = sender as? FileTableViewCell,
                let destination = segue.destinationViewController as? ViewFileViewController else {
                return
            }
            destination.correspondingFile = cell.correspondingFile
        }
    }
}
