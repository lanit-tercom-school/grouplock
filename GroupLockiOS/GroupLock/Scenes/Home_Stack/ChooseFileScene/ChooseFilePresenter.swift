//
//  ChooseFilePresenter.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import JSQDataSourcesKit

protocol ChooseFilePresenterInput {
    func presentFiles(response response: ChooseFile.Configure.Response)
}

protocol ChooseFilePresenterOutput: class {
    func displayFiles(with viewModel: ChooseFile.Configure.ViewModel)
}

class ChooseFilePresenter: ChooseFilePresenterInput {
    
    weak var output: ChooseFilePresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentFiles(response response: ChooseFile.Configure.Response) {
        
        let fileInfoDataSource = PresentedDataSource(dataSourceToPresent: response.fetchedResultsController)
        { (file) -> ChooseFile.Configure.ViewModel.FileInfo in
            
            let fileName = file.name
            var thumbnail: UIImage?
            if let fileContents = file.contents {
                thumbnail = UIImage(data: fileContents)
            }
            
            let fileInfo = ChooseFile.Configure.ViewModel.FileInfo(name: fileName, thumbnail: thumbnail)
            return fileInfo
        }
        
        let viewModel = ChooseFile.Configure.ViewModel(fileInfoDataSource: fileInfoDataSource)
        output.displayFiles(with: viewModel)
    }
}
