//
//  EncryptedFilePresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol EncryptedFilePresenterInput {
    func presentFiles(_ response: EncryptedFile.Fetch.Response)
    func shareFiles(_ response: EncryptedFile.Share.Response)
}

protocol EncryptedFilePresenterOutput: class {
    func displayFiles(_ viewModel: EncryptedFile.Fetch.ViewModel)
    func displaySharingInterface(_ response: EncryptedFile.Share.Response)
}

class EncryptedFilePresenter: EncryptedFilePresenterInput {

    weak var output: EncryptedFilePresenterOutput!

    // MARK: - Presentation logic

    func presentFiles(_ response: EncryptedFile.Fetch.Response) {

        let fileInfo: [EncryptedFile.Fetch.ViewModel.FileInfo] = response.files.map {

            if let data = $0.contents, let thumbnail = UIImage(data: data) {
                return EncryptedFile.Fetch.ViewModel.FileInfo(fileName: $0.name,
                                                                  fileThumbnail: thumbnail,
                                                                  encrypted: $0.encrypted)
            }

            return EncryptedFile.Fetch.ViewModel.FileInfo(fileName: $0.name,
                                                              fileThumbnail: UIImage(),
                                                              encrypted: $0.encrypted)
        }

        output.displayFiles(EncryptedFile.Fetch.ViewModel(fileInfo: fileInfo))
    }

    func shareFiles(_ response: EncryptedFile.Share.Response) {

        // Bypassing the Presenter here
        output.displaySharingInterface(response)
    }
}
