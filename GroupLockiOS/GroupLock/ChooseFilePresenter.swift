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
    func presentFiles(response response: ChooseFileResponse)
}

protocol ChooseFilePresenterOutput: class {
    func displayCollectionView(with viewModel: ChooseFileViewModel)
}

class ChooseFilePresenter: ChooseFilePresenterInput {
    
    weak var output: ChooseFilePresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentFiles(response response: ChooseFileResponse) {
        
        let formatFileInfo = { (file: File) -> ChooseFileViewModel.FileInfo in
            
            var thumbnail: UIImage?
            
            if let fileContents = file.contents {
                thumbnail = UIImage(data: fileContents)
            }
            
            return ChooseFileViewModel.FileInfo(name: file.name, thumbnail: thumbnail)
        }
        
        let viewModel = ChooseFileViewModel(fetchedResultsController: response.fetchedResultsController,
                                            formatFileInfo: formatFileInfo)
        
        output.displayCollectionView(with: viewModel)
    }
    
    
}
