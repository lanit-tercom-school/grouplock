//
//  PresentedDataSourceTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import JSQDataSourcesKit
@testable import GroupLock

struct Seeds {
    struct DataSource {
        static let numberOfSections = 23
        static let numberOfItemsInSection = 42
        static let itemsInSection = [4, 8, 15, 16, 23, 42]
        static let itemAtRowInSection = 42
        static let headerTitleInSection = "Header title in section"
        static let footerTitleInSection = "Footer title in section"
    }
}

class PresentedDataSourceTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: PresentedDataSource<DataSourceStub, String>!
    
    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        
        let dataSourceStub = DataSourceStub()
        sut = PresentedDataSource(dataSourceToPresent: dataSourceStub,
                                  formatDataSource: dataSourceFormatterFake)
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    class DataSourceStub: DataSourceProtocol {
        
        typealias Item = Int
        
        func numberOfSections() -> Int {
            return Seeds.DataSource.numberOfSections
        }
        
        func numberOfItems(inSection section: Int) -> Int {
            return Seeds.DataSource.numberOfItemsInSection
        }
        
        /// Returns nil iff section > 0
        func items(inSection section: Int) -> [Item]? {
            return section > 0 ? nil : Seeds.DataSource.itemsInSection
        }
        
        /// Returns nil iff section > 0
        func item(atRow row: Int, inSection section: Int) -> Item? {
            return section > 0 ? nil : Seeds.DataSource.itemAtRowInSection
        }
        
        /// Returns nil iff section > 0
        func headerTitle(inSection section: Int) -> String? {
            return section > 0 ? nil : Seeds.DataSource.headerTitleInSection
        }
        
        /// Returns nil iff section > 0
        func footerTitle(inSection section: Int) -> String? {
            return section > 0 ? nil : Seeds.DataSource.footerTitleInSection
        }
    }
    
    let dataSourceFormatterFake = { (item: Int) -> String in "\(item)" }
    
    // MARK: - Tests
    
    func test_ThatPresentedDataSource_ReturnsNumberOfSections() {
        
        // Given
        let expectedNumberOfSections = Seeds.DataSource.numberOfSections
        
        // When
        let returnedNumberOfSections = sut.numberOfSections()
        
        // Then
        XCTAssertEqual(returnedNumberOfSections, expectedNumberOfSections,
                       "PresentedDataSource should return the same number of sections as in its underlying data source")
    }
    
    func test_ThatPresentedDataSource_ReturnsNumberOfItemsInSection() {
        
        // Given
        let expectedNumberOfItems = Seeds.DataSource.numberOfItemsInSection
        
        // When
        let returnedNumberOfItems = sut.numberOfItems(inSection: 0)
        
        // Then
        XCTAssertEqual(returnedNumberOfItems, expectedNumberOfItems,
                       "PresentedDataSource should return the same number of items in a section" +
            "as does its underlying data source")
    }
    
    func test_ThatPresentedDataSource_ReturnsItemsInSection() {
        
        // Given
        let expectedItems = Seeds.DataSource.itemsInSection.map { dataSourceFormatterFake($0) }
        
        // When
        let returnedItems = sut.items(inSection: 0)
        
        // Then
        XCTAssertNotNil(returnedItems)
        XCTAssertEqual(returnedItems!, expectedItems,
                       "PresentedDataSource should return formatted items in a section")
        
        // When
        let returnedItemsIfNil = sut.items(inSection: 1)
        
        // Then
        XCTAssertNil(returnedItemsIfNil,
                     "PresentedDataSource should return nil if its underlying data source returns nil")
        
    }
    
    func test_ThatPresentedDataSource_ReturnsItemAtRowInSection() {
        
        // Given
        let expectedItem = dataSourceFormatterFake(Seeds.DataSource.itemAtRowInSection)
        
        // When
        let returnedItem = sut.item(atRow: 0, inSection: 0)
        
        // Then
        XCTAssertNotNil(returnedItem)
        XCTAssertEqual(returnedItem!, expectedItem,
                       "PresentedDataSource should return formatted item at a row in a section")
        
        // When
        let returnedItemIfNil = sut.item(atRow: 0, inSection: 1)
        
        // Then
        XCTAssertNil(returnedItemIfNil,
                     "PresentedDataSource should return nil if its underlying data source returns nil")
    }
    
    func test_ThatPresentedDataSource_ReturnsHeaderAndFooterTitleInSection() {
        
        // Given
        let expectedHeader = Seeds.DataSource.headerTitleInSection
        let expectedFooter = Seeds.DataSource.footerTitleInSection
        
        // When
        let returnedHeader = sut.headerTitle(inSection: 0)
        let returnedFooter = sut.footerTitle(inSection: 0)
        
        // Then
        XCTAssertNotNil(returnedFooter)
        XCTAssertNotNil(returnedHeader)
        XCTAssertEqual(returnedHeader!, expectedHeader,
                       "PresentedDataSource should return the same header title as in its underlying data source")
        XCTAssertEqual(returnedFooter!, expectedFooter,
                       "PresentedDataSource should return the same footer title as in its underlying data source")
        
        // When
        let returnedHeaderIfNil = sut.headerTitle(inSection: 1)
        let returnedFooterIfNil = sut.footerTitle(inSection: 1)
        
        // Then
        XCTAssertNil(returnedHeaderIfNil,
                     "PresentedDataSource should return nil if its underlying data source returns nil")
        XCTAssertNil(returnedFooterIfNil,
                     "PresentedDataSource should return nil if its underlying data source returns nil")
    }
}
