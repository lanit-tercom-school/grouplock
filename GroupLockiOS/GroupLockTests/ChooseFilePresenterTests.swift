//
//  ChooseFilePresenterTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import JSQDataSourcesKit
import CoreData
@testable import GroupLock

class ChooseFilePresenterTests: XCTestCase {
    
    struct Seeds {
        struct FileFormat {
            static let fileName = "File Name"
            static let fileContents = NSData(contentsOfFile: "test-image")
            static let fileThumbnail = UIImage()
        }
    }
    
    // MARK: Subject under test
    var sut: ChooseFilePresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = ChooseFilePresenter()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    
    // MARK: - Tests

}
