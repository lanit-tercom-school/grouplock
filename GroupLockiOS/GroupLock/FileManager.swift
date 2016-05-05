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
    
    /// Provides an array of folders of the root directory
    var rootDirectory: [Folder] {
        let rootFetchRequest = managedObjectModel.fetchRequestTemplateForName("RootFetchRequest")
        do {
            let folders = try managedObjectContext.executeFetchRequest(rootFetchRequest!) as! [Folder]
            return folders
        } catch {
            print(error)
            abort()
        }
    }
    
    /**
     Executes a request for all the folders contained in folder `directory` and returns an array of them.
     
     - parameter directory: The folder we want to get subfolders of.
     
     - returns: An array of folders.
     */
    func folders(insideDirectory directory: Folder) -> [Folder] {
        let fetchRequest = NSFetchRequest(entityName: "Folder")
        fetchRequest.predicate = NSPredicate(format: "superfolder == %@", directory)
        
        do {
            let folders = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Folder]
            return folders
        } catch {
            print(error)
            abort()
        }
    }
    
    /**
     Executes a request for all the files contained in folder `directory` and returns an array of them.
     
     - parameter directory: The folder we want to get files contained in.
     
     - returns: An array of files.
     */
    func files(insideDirectory directory: Folder) -> [File] {
        let fetchRequest = NSFetchRequest(entityName: "File")
        fetchRequest.predicate = NSPredicate(format: "folder == %@", directory)
        
        do {
            let files = try managedObjectContext.executeFetchRequest(fetchRequest) as! [File]
            return files
        } catch {
            print(error)
            abort()
        }
    }
    

    /**
     Loads the default set of folders into the persistent store.
     */
    func initializeStoreWithDefaultData() {
        
        let encryptedFolder = Folder(name: "Encrypted", insertIntoManagedObjectContext: managedObjectContext)
        let decryptedFolder = Folder(name: "Decrypted", insertIntoManagedObjectContext: managedObjectContext)
        
        // TODO: Use Dependency Injection
        
        // This is hardcode for simulating a file structure
        #if DEBUG
            
            let subfolderInEncryptedFolder = Folder(name: "Encrypted Subfolder 1",
                                                    insertIntoManagedObjectContext: managedObjectContext)
            subfolderInEncryptedFolder.superfolder = encryptedFolder
            
            let subfolderInDecryptedFolder = Folder(name: "Decrypted Subfolder 1",
                                                    insertIntoManagedObjectContext: managedObjectContext)
            subfolderInDecryptedFolder.superfolder = decryptedFolder
            
            let fileInEncryptedFolder = File(name: "Encrypted File 1",
                                             insertIntoManagedObjectContext: managedObjectContext)
            fileInEncryptedFolder.encrypted = true
            fileInEncryptedFolder.folder = encryptedFolder
            
            let fileInDecryptedFolder = File(name: "Unencrypted File 1",
                                             insertIntoManagedObjectContext: managedObjectContext)
            fileInDecryptedFolder.encrypted = false
            fileInDecryptedFolder.folder = decryptedFolder
            
        #endif
        
        
        AppDelegate.sharedInstance.saveContext()
    }
    
    
}
