//
//  FileManager.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData

class FileManager: NSObject {
    
    /*!
     * @discussion Provides a singleton object of a file manager.
     */
    static let sharedInstance = FileManager()
    
    /*!
     * @discussion Loads the default set of folders into the persistent store. The set must be described in default_folders.json file.
     */
    static func initializeStoreWithDefaultData() {
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        let jsonFile: NSURL! = NSBundle.mainBundle().URLForResource("default_folders",
                                                                    withExtension: "json")
        let jsonData = NSData(contentsOfURL: jsonFile)!
        var jsonObject: [String : AnyObject]?
        var preloadedFolders = [String]()
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData,
                                                                    options: NSJSONReadingOptions(rawValue: 0)) as? [String : AnyObject]
        } catch {
            
        }
        
        guard let folders = jsonObject!["folders"] as? [AnyObject] else {
            return
        }
        
        for folder in folders {
            guard let folderDict = folder as? [String : AnyObject] else {
                continue
            }
            guard let name = folderDict["name"] as? String else {
                continue
            }
            
            preloadedFolders.append(name)
        }
        
        for folderName in preloadedFolders {
            guard let unwrappedManagedObjectContext = managedObjectContext else {
                continue
            }
            let folderEntity = NSEntityDescription.insertNewObjectForEntityForName("Folder",
                                                                                   inManagedObjectContext: unwrappedManagedObjectContext) as! Folder
            folderEntity.name = folderName
        }
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.saveContext()
    }
    
    
}
