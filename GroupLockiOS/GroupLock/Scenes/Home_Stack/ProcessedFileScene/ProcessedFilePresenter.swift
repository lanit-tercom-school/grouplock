//
//  ProcessedFilePresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProcessedFilePresenterInput {
    func presentFiles(_ response: ProcessedFile.Fetch.Response)
    func shareFiles(_ response: ProcessedFile.Share.Response)
}

protocol ProcessedFilePresenterOutput: class {
    func displayFiles(_ viewModel: ProcessedFile.Fetch.ViewModel)
    func displaySharingInterface(_ response: ProcessedFile.Share.Response)
}

class ProcessedFilePresenter: ProcessedFilePresenterInput {

    weak var output: ProcessedFilePresenterOutput!

    // MARK: - Presentation logic

    func presentFiles(_ response: ProcessedFile.Fetch.Response) {

        let fileInfo: [ProcessedFile.Fetch.ViewModel.FileInfo] = response.files.map {

            if let data = $0.contents, let thumbnail = UIImage(data: data) {
                return ProcessedFile.Fetch.ViewModel.FileInfo(fileName: $0.name,
                                                                  fileThumbnail: thumbnail,
                                                                  encrypted: $0.encrypted)
            }

            return ProcessedFile.Fetch.ViewModel.FileInfo(fileName: $0.name,
                                                              fileThumbnail: UIImage(),
                                                              encrypted: $0.encrypted)
        }

        output.displayFiles(ProcessedFile.Fetch.ViewModel(fileInfo: fileInfo))
    }

    func shareFiles(_ response: ProcessedFile.Share.Response) {

        // Bypassing the Presenter here
        output.displaySharingInterface(response)
    }
}
