//
//  ProcessedFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProcessedFileInteractorInput {
    var files: [File] { get set }
    var processedFiles: [File] { get }
    var encryptionKey: [String] { get set }

    func encryptFiles(_ request: ProcessedFile.Fetch.Request)
    func prepareFilesForSharing(_ request: ProcessedFile.Share.Request)
    func fileSelected(_ request: ProcessedFile.SelectFiles.Request)
    func fileDeselected(_ request: ProcessedFile.SelectFiles.Request)
    func saveFiles(_ request: ProcessedFile.SaveFiles.Request)
}

protocol ProcessedFileInteractorOutput {
    func presentFiles(_ response: ProcessedFile.Fetch.Response)
    func shareFiles(_ response: ProcessedFile.Share.Response)
}

class ProcessedFileInteractor: ProcessedFileInteractorInput {

    var output: ProcessedFileInteractorOutput!
    private var cryptoLibrary: CryptoWrapperProtocol = CryptoFake()

    // MARK: - Business logic

    var files: [File] = []
    var processedFiles: [File] = []

    private var selectedFiles = Set<IndexPath>()

    var encryptionKey: [String] = []

    func encryptFiles(_ request: ProcessedFile.Fetch.Request) {

        func encrypt(_ file: File, withKey key: [String]) -> File {
            if let dataToEncrypt = file.contents {
                let encryptedData = cryptoLibrary.encrypt(image: dataToEncrypt, withEncryptionKey: key)
                var encryptedFile = file
                encryptedFile.contents = encryptedData
                encryptedFile.encrypted = true
                return encryptedFile
            } else {
                return file
            }
        }

        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            self.processedFiles = self.files.map { encrypt($0, withKey: self.encryptionKey) }

            DispatchQueue.main.async { [unowned self] in
                self.output.presentFiles(ProcessedFile.Fetch.Response(files: self.processedFiles))
            }
        }
    }

    func prepareFilesForSharing(_ request: ProcessedFile.Share.Request) {

        let dataToShare = selectedFiles.map { processedFiles[$0.item].contents ?? Data() }
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

        let response = ProcessedFile.Share.Response(dataToShare: dataToShare,
                                                    excludedActivityTypes: excludedActivityTypes)
        output.shareFiles(response)
    }

    func fileSelected(_ request: ProcessedFile.SelectFiles.Request) {
        selectedFiles.insert(request.indexPath)
    }

    func fileDeselected(_ request: ProcessedFile.SelectFiles.Request) {
        selectedFiles.remove(request.indexPath)
    }

    func saveFiles(_ request: ProcessedFile.SaveFiles.Request) {

        for file in processedFiles {
            _ = ManagedFile(file, insertIntoManagedObjectContext: AppDelegate.sharedInstance.managedObjectContext)
        }

        AppDelegate.sharedInstance.saveContext()
    }
}
