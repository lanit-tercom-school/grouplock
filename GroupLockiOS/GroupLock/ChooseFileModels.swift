//
//  ChooseFileModels.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import JSQDataSourcesKit

struct ChooseFileRequest {
    
}

struct ChooseFileResponse {
    var fetchedResultsController: FetchedResultsController<File>
}

struct ChooseFileViewModel {
    
    struct FileInfo {
        var name: String
        var thumbnail: UIImage?
    }
    
    var fetchedResultsController: FetchedResultsController<File>
    var formatFileInfo: (File) -> FileInfo
}
