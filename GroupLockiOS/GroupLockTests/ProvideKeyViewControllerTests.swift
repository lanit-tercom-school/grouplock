//
//  ProvideKeyViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class ProvideKeyViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: ProvideKeyViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupProvideKeyViewController()
    }

    override func tearDown() {

        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupProvideKeyViewController() {

        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard
            .instantiateViewControllerWithIdentifier("ProvideKeyViewController") as! ProvideKeyViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }

    // MARK: - Test doubles

    // MARK: - Tests

}
// swiftlint:enable force_cast
