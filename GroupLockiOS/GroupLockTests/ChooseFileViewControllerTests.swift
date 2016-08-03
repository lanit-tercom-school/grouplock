//
//  ChooseFileViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 13.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class ChooseFileViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: ChooseFileViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupChooseFileViewController()
    }

    override func tearDown() {

        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupChooseFileViewController() {

        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard
            .instantiateViewControllerWithIdentifier("ChooseFileViewController") as! ChooseFileViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }

    // MARK: - Test doubles

    // MARK: - Tests

}
// swiftlint:enable force_cast
