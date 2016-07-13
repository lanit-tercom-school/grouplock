//
//  ChooseFileWorker.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import CoreData
import JSQDataSourcesKit

class ChooseFileWorker {
    
    // MARK: Business Logic
    
    func createFetchRequest(forEncryptedFiles encrypted: Bool) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "File")
        fetchRequest.predicate = NSPredicate(format: "encrypted == \(encrypted)")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        return fetchRequest
    }
    
    
    func createFetchedResultsController(with fetchRequest: NSFetchRequest) -> FetchedResultsController<File> {
        
        let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
        let fetchedResultsController = FetchedResultsController<File>(fetchRequest: fetchRequest,
                                                                      managedObjectContext: managedObjectContext,
                                                                      sectionNameKeyPath: nil,
                                                                      cacheName: nil)
        return fetchedResultsController
    }
}
