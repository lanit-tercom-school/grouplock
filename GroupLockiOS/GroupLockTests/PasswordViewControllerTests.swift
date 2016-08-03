//
//  PasswordViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class PasswordViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: PasswordViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupPasswordViewController()
    }

    override func tearDown() {

        window = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupPasswordViewController() {

        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewControllerWithIdentifier(
            "PasswordViewController") as! PasswordViewController

        _ = sut.view
        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }

    // MARK: - Test doubles

    class PasswordViewControllerOutputSpy: PasswordViewControllerOutput {

        var passwordIsCorrect_isCalled = false // swiftlint:disable:this variable_name

        func passwordIsCorrect(password: String?) -> Bool {

            passwordIsCorrect_isCalled = true
            return true
        }
    }

    class PasswordViewControllerOutputStub: PasswordViewControllerOutput {

        private var passwordIsCorrectValue: Bool

        init(passwordIsCorrectValue: Bool) {
            self.passwordIsCorrectValue = passwordIsCorrectValue
        }

        func passwordIsCorrect(password: String?) -> Bool {
            return passwordIsCorrectValue
        }
    }

    class PasswordRouterSpy: PasswordRouter {

        var navigateToMainScreen_isCalled = false // swiftlint:disable:this variable_name

        override func navigateToMainScreen() {
            navigateToMainScreen_isCalled = true
        }
    }

    // MARK: - Tests

    func test_ThatPasswordTextField_BecomesFirstResponderWhenViewIsLoaded() {
        XCTAssertTrue(sut.passwordTextField.isFirstResponder(),
                      "Password Text Field should be in focus when the view is loaded")
    }

    func test_ThatProceedButton_IsInitiallyHidden() {

        // Given
        let proceedButton = sut.proceedButton

        // When

        // Then
        XCTAssertTrue(proceedButton.hidden, "Proceed button should be hidden when view is initially loaded")
    }

    func test_ThatProceedButton_IsHiddenWhenPasswordTextFieldIsEmpty() {

        // Given
        let proceedButton = sut.proceedButton
        let textField = UITextField()

        // When
        textField.text = nil
        sut.textFieldEditingChanged(textField)

        // Then
        XCTAssertTrue(proceedButton.hidden,
                      "Proceed button should be hidden when the text field's text is not specified")

        // When
        textField.text = ""
        sut.textFieldEditingChanged(textField)

        // Then
        XCTAssertTrue(proceedButton.hidden, "Proceed button should be hidden when the text field is empty")
    }

    func test_ThatProceedButton_IsShownWhenPasswordTextFieldIsNotEmpty() {

        // Given
        let proceedButton = sut.proceedButton
        let textField = UITextField()

        // When
        textField.text = "something"
        sut.textFieldEditingChanged(textField)

        // Then
        XCTAssertFalse(proceedButton.hidden, "Proceed button should be shown when the text field is not empty")
    }

    func test_ThatProceedButton_TriggersPasswordCheck() {

        // Given
        let passwordViewControllerOutputSpy = PasswordViewControllerOutputSpy()
        sut.output = passwordViewControllerOutputSpy

        // When
        sut.onProceedButton()

        // Then
        XCTAssertTrue(passwordViewControllerOutputSpy.passwordIsCorrect_isCalled,
                  "Proceed button should trigger password check")
    }

    func test_ThatTextField_TriggersPasswordCheck() {

        // Given
        let passwordViewControllerOutputSpy = PasswordViewControllerOutputSpy()
        sut.output = passwordViewControllerOutputSpy
        let textField = UITextField()

        // When
        sut.textFieldShouldReturn(textField)

        // Then
        XCTAssertTrue(passwordViewControllerOutputSpy.passwordIsCorrect_isCalled,
                  "Password Text Field should trigger password check when it returns")
    }

    func test_ThatProceedButton_GrantsAccessIfPasswordIsCorrect() {

        // Given
        let passwordViewControllerOutputStub = PasswordViewControllerOutputStub(passwordIsCorrectValue: true)
        sut.output = passwordViewControllerOutputStub

        let passwordRouterSpy = PasswordRouterSpy()
        sut.router = passwordRouterSpy

        // When
        sut.onProceedButton()

        // Then
        XCTAssertTrue(passwordRouterSpy.navigateToMainScreen_isCalled,
                      "If the password is correct, we should segue to the main screen")
        XCTAssertFalse(sut.passwordTextField.isFirstResponder(),
                       "Password Text Field should lose focus if the password is correct")
    }

    func test_ThatTextField_GrantsAccessIfPasswordIsCorrect() {

        // Given
        let passwordViewControllerOutputStub = PasswordViewControllerOutputStub(passwordIsCorrectValue: true)
        sut.output = passwordViewControllerOutputStub

        let passwordRouterSpy = PasswordRouterSpy()
        sut.router = passwordRouterSpy

        // When
        sut.textFieldShouldReturn(sut.passwordTextField)

        // Then
        XCTAssertTrue(passwordRouterSpy.navigateToMainScreen_isCalled,
                      "If the password is correct, we should segue to the main screen")
        XCTAssertFalse(sut.passwordTextField.isFirstResponder(),
                       "Password Text Field should lose focus if the password is correct")
    }

    func test_ThatProceedButton_DeniesAccessIfPasswordIsIncorrect() {

        // Given
        let passwordViewControllerOutputStub = PasswordViewControllerOutputStub(passwordIsCorrectValue: false)
        sut.output = passwordViewControllerOutputStub

        let passwordRouterSpy = PasswordRouterSpy()
        sut.router = passwordRouterSpy

        // When
        sut.onProceedButton()

        // Then
        XCTAssertFalse(passwordRouterSpy.navigateToMainScreen_isCalled,
                       "If the password is incorrect, no segue should be performed")
        XCTAssertTrue(sut.passwordTextField.isFirstResponder(),
                      "Password Text Field should keep focus if the password is incorrect")
    }

    func test_ThatTextField_DeniesAccessIfPasswordIsIncorrect() {

        // Given
        let passwordViewControllerOutputStub = PasswordViewControllerOutputStub(passwordIsCorrectValue: false)
        sut.output = passwordViewControllerOutputStub

        let passwordRouterSpy = PasswordRouterSpy()
        sut.router = passwordRouterSpy

        // When
        sut.textFieldShouldReturn(sut.passwordTextField)

        // Then
        XCTAssertFalse(passwordRouterSpy.navigateToMainScreen_isCalled,
                       "If the password is incorrect, no segue should be performed")
        XCTAssertTrue(sut.passwordTextField.isFirstResponder(),
                      "Password Text Field should keep focus if the password is incorrect")
    }
}
// swiftlint:enable force_cast
