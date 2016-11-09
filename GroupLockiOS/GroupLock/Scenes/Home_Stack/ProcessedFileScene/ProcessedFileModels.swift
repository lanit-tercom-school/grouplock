//
//  ProcessedFileModels.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: Scene
struct ProcessedFile {

    // MARK: Use Case
    struct Fetch {

        struct Request {}

        struct Response {
            let files: [File]
        }

        struct ViewModel {

            struct FileInfo {
                let fileName: String
                let fileThumbnail: UIImage
                let encrypted: Bool
            }

            let fileInfo: [FileInfo]
        }
    }

    // MARK: Use Case
    struct Share {

        struct Request {}

        struct Response {
            var dataToShare: [Data]
            var excludedActivityTypes: [UIActivityType]?
        }
    }

    // MARK: Use Case
    struct SelectFiles {

        struct Request {
            let indexPath: IndexPath
        }

        struct Response {}

        struct ViewModel {}
    }

    // MARK: Use Case
    struct SaveFiles {

        struct Request {}
    }
}
