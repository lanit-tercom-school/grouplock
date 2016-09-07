//
//  ChooseFileWorker.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import CoreData
import JSQDataSourcesKit
import JSQCoreDataKit

class ChooseFileWorker {

    // MARK: Business Logic

    func createFetchedResultsController(forEncryptedFiles encrypted: Bool) ->
        FetchedResultsController<ManagedFile> {

            let fetchRequest: NSFetchRequest<NSFetchRequestResult>

            if #available(iOS 10.0, *) {
                fetchRequest = ManagedFile.fetchRequest()
            } else {
                fetchRequest = NSFetchRequest(entityName: "File")
            }

            fetchRequest.predicate = NSPredicate(format: "encrypted == \(encrypted)")
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "name", ascending: true)
            ]

            let context = AppDelegate.sharedInstance.managedObjectContext
            let fetchedResultsController = FetchedResultsController<ManagedFile>(fetchRequest: fetchRequest,
                                                                                 managedObjectContext: context,
                                                                                 sectionNameKeyPath: nil,
                                                                                 cacheName: nil)
            return fetchedResultsController
    }
}
