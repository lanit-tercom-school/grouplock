//
//  EncryptedFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileInteractorInput {
    var encryptedFiles: [File] { get set }

    func fetchFiles(_ request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(_ request: EncryptedFile.Share.Request)
    func fileSelected(_ request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(_ request: EncryptedFile.SelectFiles.Request)
    func saveFiles(_ request: EncryptedFile.SaveFiles.Request)
}

protocol EncryptedFileInteractorOutput {
    func presentFiles(_ response: EncryptedFile.Fetch.Response)
    func shareFiles(_ response: EncryptedFile.Share.Response)
}

// swiftlint:disable line_length
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
// swiftlint:enable line_length

class EncryptedFileInteractor: EncryptedFileInteractorInput {

    var output: EncryptedFileInteractorOutput!

    // MARK: - Business logic

    var encryptedFiles: [File] = []/* = HardcodedFiles.ef */

    private var selectedFiles = Set<IndexPath>()

    func fetchFiles(_ request: EncryptedFile.Fetch.Request) {

        let response = EncryptedFile.Fetch.Response(files: encryptedFiles)
        output.presentFiles(response)
    }

    func prepareFilesForSharing(_ request: EncryptedFile.Share.Request) {

        let dataToShare = selectedFiles.map { encryptedFiles[$0.item].contents ?? Data() }
        let excludedActivityTypes: [UIActivityType] = [
            .print,
            .postToVimeo,
            .postToWeibo,
            .postToFlickr,
            .postToTwitter,
            .postToFacebook,
            .addToReadingList,
            .postToTencentWeibo
        ]

        let response = EncryptedFile.Share.Response(dataToShare: dataToShare,
                                                    excludedActivityTypes: excludedActivityTypes)
        output.shareFiles(response)
    }

    func fileSelected(_ request: EncryptedFile.SelectFiles.Request) {
        selectedFiles.insert(request.indexPath)
    }

    func fileDeselected(_ request: EncryptedFile.SelectFiles.Request) {
        selectedFiles.remove(request.indexPath)
    }

    func saveFiles(_ request: EncryptedFile.SaveFiles.Request) {

        for file in encryptedFiles {
            _ = ManagedFile(file, insertIntoManagedObjectContext: AppDelegate.sharedInstance.managedObjectContext)
        }

        AppDelegate.sharedInstance.saveContext()
    }
}
