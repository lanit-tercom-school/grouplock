//
//  EncryptedFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFileInteractorInput {
    var files: [File] { get set }
    var encryptedFiles: [File] { get }
    var encryptionKey: [String] { get set }

    func encryptFiles(_ request: EncryptedFile.Fetch.Request)
    func prepareFilesForSharing(_ request: EncryptedFile.Share.Request)
    func fileSelected(_ request: EncryptedFile.SelectFiles.Request)
    func fileDeselected(_ request: EncryptedFile.SelectFiles.Request)
    func saveFiles(_ request: EncryptedFile.SaveFiles.Request)
}

protocol EncryptedFileInteractorOutput {
    func presentFiles(_ response: EncryptedFile.Fetch.Response)
    func shareFiles(_ response: EncryptedFile.Share.Response)
}

class EncryptedFileInteractor: EncryptedFileInteractorInput {

    var output: EncryptedFileInteractorOutput!
    private var cryptoLibrary: CryptoWrapperProtocol = CryptoFake()

    // MARK: - Business logic

    var files: [File] = []
    var encryptedFiles: [File] = []

    private var selectedFiles = Set<IndexPath>()

    var encryptionKey: [String] = []

    func encryptFiles(_ request: EncryptedFile.Fetch.Request) {

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
            self.encryptedFiles = self.files.map { encrypt($0, withKey: self.encryptionKey) }

            DispatchQueue.main.async { [unowned self] in
                self.output.presentFiles(EncryptedFile.Fetch.Response(files: self.encryptedFiles))
            }
        }
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
