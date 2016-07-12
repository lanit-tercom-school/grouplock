//
//  ChooseFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import CoreData
import JSQDataSourcesKit

protocol ChooseFileInteractorInput {
    var files: [File] { get set }
    var selectedFiles: [Int : File] { get set }
    
    func fetchFiles()
}

protocol ChooseFileInteractorOutput {
    func presentFiles(response response: ChooseFileResponse)
}

class ChooseFileInteractor: ChooseFileInteractorInput {
    
    var output: ChooseFileInteractorOutput!
    var worker: ChooseFileWorker!
    
    // MARK: - Business logic
    
    var files = [File]()
    var selectedFiles = [Int : File]()
    
    func fetchFiles() {
        
        let fetchRequest = NSFetchRequest(entityName: "File")
        fetchRequest.predicate = NSPredicate(format: "encrypted == false")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext
        
        let fetchedResultsController = FetchedResultsController<File>(fetchRequest: fetchRequest,
                                                                      managedObjectContext: managedObjectContext,
                                                                      sectionNameKeyPath: nil,
                                                                      cacheName: nil)
        let response = ChooseFileResponse(fetchedResultsController: fetchedResultsController)
        
        output.presentFiles(response: response)
    }
}
