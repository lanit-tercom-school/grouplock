//
//  FileManager.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData

/// FileManager object represents a singleton for imitating file system structure for Library.
class FileManager: NSObject {
    
    /// Provides a singleton object of a file manager.
    static let sharedInstance = FileManager()
    
    private override init() {}
    
    private var managedObjectContext: NSManagedObjectContext {
        return AppDelegate.sharedInstance.managedObjectContext
    }
    private var managedObjectModel: NSManagedObjectModel {
        return AppDelegate.sharedInstance.managedObjectModel
    }
    
    /**
     Executes a request for all the files contained in `directory` and returns an array of them.
     
     - parameter directory: The directory we want to get files contained in.
     
     - returns: An array of files.
     */
    func files(insideDirectory directory: Directory) -> [File] {
        let fetchRequest = NSFetchRequest(entityName: "File")        
        do {
            let files = try managedObjectContext.executeFetchRequest(fetchRequest) as! [File]
            return files
        } catch {
            print(error)
            abort()
        }
    }   
    
}
