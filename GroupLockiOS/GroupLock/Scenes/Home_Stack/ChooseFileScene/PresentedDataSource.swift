//
//  PresentedDataSource.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import JSQDataSourcesKit

class PresentedDataSource<DataSource: DataSourceProtocol, ViewModel>: DataSourceProtocol {

    private var dataSourceToPresent: DataSource
    private var formatDataSource: (DataSource.Item) -> ViewModel

    init(dataSourceToPresent: DataSource, formatDataSource: @escaping (DataSource.Item) -> ViewModel) {
        self.dataSourceToPresent = dataSourceToPresent
        self.formatDataSource = formatDataSource
    }

    func setFormatDataSource(_ closure: @escaping (DataSource.Item) -> ViewModel) {
        formatDataSource = closure
    }

    func numberOfSections() -> Int {
        return dataSourceToPresent.numberOfSections()
    }

    func numberOfItems(inSection section: Int) -> Int {
        return dataSourceToPresent.numberOfItems(inSection: section)
    }

    func items(inSection section: Int) -> [ViewModel]? {
        let fetchedItems = dataSourceToPresent.items(inSection: section)
        return fetchedItems?.map { formatDataSource($0) }
    }

    func item(atRow row: Int, inSection section: Int) -> ViewModel? {
        guard let fetchedItem = dataSourceToPresent.item(atRow: row, inSection: section) else {
            return nil
        }
        return formatDataSource(fetchedItem)
    }

    func headerTitle(inSection section: Int) -> String? {
        return dataSourceToPresent.headerTitle(inSection: section)
    }

    func footerTitle(inSection section: Int) -> String? {
        return dataSourceToPresent.footerTitle(inSection: section)
    }
}
