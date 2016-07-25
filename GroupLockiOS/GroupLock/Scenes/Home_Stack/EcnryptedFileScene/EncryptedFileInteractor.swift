//
//  EncryptedFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileInteractorInput {
    var encryptedFiles: [File]! { get set }
    
    func fetchFiles(request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(request: EncryptedFile.Share.Request)
    func fileSelected(request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(request: EncryptedFile.SelectFiles.Request)
    func saveFiles(request: EncryptedFile.SaveFiles.Request)
}

protocol EncryptedFileInteractorOutput {
    func presentFiles(response: EncryptedFile.Fetch.Response)
    func shareFiles(response: EncryptedFile.Share.Response)
}

/*
struct HardcodedFiles {
    static let ef = [
        File(name: "File 1", type: "JPG", encrypted: true, contents: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("test-image", withExtension: "png")!)),
        File(name: "File 2", type: "JPG", encrypted: true, contents: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("test-image", withExtension: "png")!)),
        File(name: "File 3", type: "JPG", encrypted: true, contents: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("test-image", withExtension: "png")!)),
        File(name: "File 4", type: "JPG", encrypted: true, contents: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("test-image", withExtension: "png")!)),
        File(name: "File 5", type: "JPG", encrypted: true, contents: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("test-image", withExtension: "png")!))
    ]
}
*/
class EncryptedFileInteractor: EncryptedFileInteractorInput {
    
    var output: EncryptedFileInteractorOutput!
    
    // MARK: - Business logic
    
    var encryptedFiles: [File]!/* = HardcodedFiles.ef */
    
    private var selectedFiles = Set<NSIndexPath>()
    
    func fetchFiles(request: EncryptedFile.Fetch.Request) {
        
        let response = EncryptedFile.Fetch.Response(files: encryptedFiles)
        output.presentFiles(response)
    }
    
    func prepareFilesForSharing(request: EncryptedFile.Share.Request) {
        
        let dataToShare = selectedFiles.map { encryptedFiles[$0.item].contents ?? NSData() }
        let excludedActivityTypes = [
            UIActivityTypePrint,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToWeibo,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToTwitter,
            UIActivityTypePostToFacebook,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToTencentWeibo
        ]
        
        let response = EncryptedFile.Share.Response(dataToShare: dataToShare,
                                                    excludedActivityTypes: excludedActivityTypes)
        output.shareFiles(response)
    }
    
    func fileSelected(request: EncryptedFile.SelectFiles.Request) {
        selectedFiles.insert(request.indexPath)
    }
    
    func fileDeselected(request: EncryptedFile.SelectFiles.Request) {
        selectedFiles.remove(request.indexPath)
    }
    
    func saveFiles(request: EncryptedFile.SaveFiles.Request) {
        
        for file in encryptedFiles {
            _ = ManagedFile(file, insertIntoManagedObjectContext: AppDelegate.sharedInstance.managedObjectContext)
        }
        
        AppDelegate.sharedInstance.saveContext()
    }
}
