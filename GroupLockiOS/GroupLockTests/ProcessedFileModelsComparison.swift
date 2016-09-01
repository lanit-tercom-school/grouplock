//
//  ProcessedFileModelsComparison.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

@testable import GroupLock

// We are using this methods and not the `==` operator so that in tests we can define equality in a diferent way.

extension ProcessedFile.Share.Response: EquatableModel {

    func isEqualTo(_ response: ProcessedFile.Share.Response) -> Bool {
        return self.dataToShare.count == response.dataToShare.count
            && !zip(self.dataToShare.sorted(), response.dataToShare.sorted()).contains { $0 != $1 }
            && ((self.excludedActivityTypes == nil && response.excludedActivityTypes == nil)
                || (self.excludedActivityTypes != nil && response.excludedActivityTypes != nil
                    // swiftlint:disable:next force_unwrapping
                    && !zip(self.excludedActivityTypes!.sorted(by: { $0.rawValue < $1.rawValue }),
                        // swiftlint:disable:next force_unwrapping
                        response.excludedActivityTypes!.sorted(by: { $0.rawValue < $1.rawValue }))
                        .contains { $0 != $1 }))
    }
}

extension ProcessedFile.Fetch.ViewModel.FileInfo: EquatableModel {

    func isEqualTo(_ fileInfo: ProcessedFile.Fetch.ViewModel.FileInfo) -> Bool {
        return self.fileName == fileInfo.fileName
            && self.encrypted == fileInfo.encrypted
            && self.fileThumbnail.isEqualToImage(fileInfo.fileThumbnail)
    }
}

extension ProcessedFile.Fetch.ViewModel: EquatableModel {

    func isEqualTo(_ viewModel: ProcessedFile.Fetch.ViewModel) -> Bool {
        return self.fileInfo.count == viewModel.fileInfo.count
            && !zip(self.fileInfo, viewModel.fileInfo).contains { !$0.isEqualTo($1) }
    }
}

extension ProcessedFile.Fetch.Response: EquatableModel {

    func isEqualTo(_ response: ProcessedFile.Fetch.Response) -> Bool {
        return self.files.count == response.files.count
            && !zip(self.files, response.files).contains { $0 != $1 }
    }
}
