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
    var cryptographicKey: [String] { get set }
    var isEncryption: Bool { get set }

    func processFiles(_ request: ProcessedFile.Fetch.Request)
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
    var cryptoLibrary: CryptoWrapperProtocol = CryptoFake()

    // MARK: - Business logic

    var files: [File] = []
    var processedFiles: [File] = []

    private var selectedFiles = Set<IndexPath>()

    var cryptographicKey: [String] = []
    var isEncryption = true

    func processFiles(_ request: ProcessedFile.Fetch.Request) {

        func process(_ file: File, withKey key: [String]) -> File {

            if let dataToEncrypt = file.contents {
                let processedData = isEncryption ?
                    cryptoLibrary.encrypt(image: dataToEncrypt, withEncryptionKey: key) :
                    cryptoLibrary.decrypt(image: dataToEncrypt, withDecryptionKey: key)

                var processedFile = file
                processedFile.contents = processedData
                processedFile.encrypted = isEncryption
                return processedFile
            } else {
                return file
            }
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let strongSelf = self {
                strongSelf.processedFiles = strongSelf
                    .files
                    .map { process($0, withKey: strongSelf.cryptographicKey) }
            }
            DispatchQueue.main.async { [weak self] in
                if let strongSelf = self {
                    strongSelf.output.presentFiles(ProcessedFile.Fetch.Response(files: strongSelf.processedFiles))
                }
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
