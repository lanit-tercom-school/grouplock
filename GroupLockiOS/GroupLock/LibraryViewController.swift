//
//  LibraryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData

class LibraryViewController: UITableViewController {
    
    /// Current list of folders displayed on the screen
    private var folders = [Folder]()
    
    /// Current list of files displayed on the screen
    private var files = [File]()
    
    /// Stack for tracking location in a structure
    private var pathStack = Stack<Folder>()
    
    let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
    let managedObjectModel = AppDelegate.sharedInstance.managedObjectModel
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if pathStack.isEmpty {
            folders = FileManager.sharedInstance.rootDirectory
            files.removeAll()
        } else {
            folders = FileManager.sharedInstance.folders(insideDirectory: pathStack.peek()!)
            files = FileManager.sharedInstance.files(insideDirectory: pathStack.peek()!)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // First section is for returning to parent directory
        // Second section lists folders
        // Third section lists files
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if pathStack.isEmpty {
                return 0
            }
            return 1
        case 1:
            return folders.count
        case 2:
            return files.count
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // FIXME: Switch-case? Maybe there is a better way?
        
        
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier("parentDirectory")!
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("folderCell",
                                                                   forIndexPath: indexPath) as! FolderTableViewCell
            cell.title.text = folders[indexPath.row].name
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("fileCell", forIndexPath: indexPath) as! FileTableViewCell
            cell.title.text = files[indexPath.row].name
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("fileCell", forIndexPath: indexPath)
            return cell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // FIXME: Switch-case? Maybe there is a better way?
        
        switch indexPath.section {
        case 0:
            pathStack.pop()
            if pathStack.isEmpty {
                folders = FileManager.sharedInstance.rootDirectory
                files.removeAll()
                break
            }
            folders = FileManager.sharedInstance.folders(insideDirectory: pathStack.peek()!)
            files = FileManager.sharedInstance.files(insideDirectory: pathStack.peek()!)
        case 1:
            let selectedFolder = folders[indexPath.row]
            folders = FileManager.sharedInstance.folders(insideDirectory: selectedFolder)
            files = FileManager.sharedInstance.files(insideDirectory: selectedFolder)
            
            pathStack.push(selectedFolder)
            
    // TODO: Implement work with files
        case 2:
            break
            
        default:
            break
        }
        
        tableView.reloadData()
    }
}
