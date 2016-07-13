//
//  FileInfoDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import JSQDataSourcesKit

struct FileInfoDataSource: DataSourceProtocol {
    
    typealias Item = ChooseFile.Configure.ViewModel.FileInfo
    
    private var fetchedResultsController: FetchedResultsController<File>
    private var formatFileInfo: (File) -> Item
    
    init(fetchedResultsController: FetchedResultsController<File>, formatFileInfo: (File) -> Item) {
        self.fetchedResultsController = fetchedResultsController
        self.formatFileInfo = formatFileInfo
    }
    
    func numberOfSections() -> Int {
        return fetchedResultsController.numberOfSections()
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return fetchedResultsController.numberOfItems(inSection: section)
    }
    
    func items(inSection section: Int) -> [Item]? {
        let fetchedItems = fetchedResultsController.items(inSection: section)
        return fetchedItems?.map { formatFileInfo($0) }
    }
    
    func item(atRow row: Int, inSection section: Int) -> Item? {
        guard let fetchedItem = fetchedResultsController.item(atRow: row, inSection: section) else {
            return nil
        }
        return formatFileInfo(fetchedItem)
    }
    
    func headerTitle(inSection section: Int) -> String? {
        return fetchedResultsController.headerTitle(inSection: section)
    }
    
    func footerTitle(inSection section: Int) -> String? {
        return fetchedResultsController.footerTitle(inSection: section)
    }
}