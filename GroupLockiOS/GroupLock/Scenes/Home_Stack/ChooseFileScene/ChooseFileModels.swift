//
//  ChooseFileModels.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import JSQDataSourcesKit

// MARK: Scene
struct ChooseFile {

    // MARK: Use Case
    struct SetDelegate {

        struct Request {
            var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate
        }

        struct Response {}

        struct ViewModel {}
    }

    // MARK: Use Case
    struct Configure {

        struct Request {
            var forEncryption: Bool
        }

        struct Response {
            var fetchedResultsController: FetchedResultsController<ManagedFile>
        }

        struct ViewModel {

            struct FileInfo: Equatable {
                var name: String
                var thumbnail: UIImage?
            }

            var fileInfoDataSource: PresentedDataSource<FetchedResultsController<ManagedFile>, FileInfo>
        }
    }

    // MARK: Use Case
    struct FetchFiles {

        struct Request {}

        struct Response {}

        struct ViewModel {}
    }

    // MARK: Use Case
    struct SelectFiles {

        struct Request {
            var indexPath: IndexPath
        }

        struct Response {}

        struct ViewModel {}
    }
}

func == (lhs: ChooseFile.Configure.ViewModel.FileInfo, rhs: ChooseFile.Configure.ViewModel.FileInfo) -> Bool {
    return lhs.name == rhs.name && lhs.thumbnail == rhs.thumbnail
}
