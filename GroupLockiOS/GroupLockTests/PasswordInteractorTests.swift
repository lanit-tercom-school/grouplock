//
//  PasswordInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class PasswordInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: PasswordInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = PasswordInteractor()
    }

    override func tearDown() {

        sut = nil
        super.tearDown()
    }

    // MARK: - Test doubles


    // MARK: - Tests

    func test_ThatPasswordIsCorrectMethod_VerifiesThePassword() {

        // Given:
        let passwordToVerify = "password"
        let expectedCorrectness = true


        // When:
        let actualCorrectness = sut.passwordIsCorrect(passwordToVerify)

        // Then:
        XCTAssertEqual(actualCorrectness, expectedCorrectness, "passwordIsCorrect(_:) should verify the password")
    }
}
