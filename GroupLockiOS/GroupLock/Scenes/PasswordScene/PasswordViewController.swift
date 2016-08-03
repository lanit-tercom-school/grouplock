//
//  PasswordViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol PasswordViewControllerInput {

    // MARK: UI-sent actions
    func onProceedButton()
    func textFieldEditingChanged(sender: UITextField)
    func textFieldShouldReturn(textField: UITextField) -> Bool
}

protocol PasswordViewControllerOutput {
    func passwordIsCorrect(password: String?) -> Bool
}

class PasswordViewController: UIViewController, PasswordViewControllerInput {

    var output: PasswordViewControllerOutput!
    var router: PasswordRouter!

    // MARK: UI elements
    @IBOutlet var enterPasswordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
    }

    // MARK: Event handling
    @IBAction func onProceedButton() {
        processPasswordFromTextField(passwordTextField)
    }

    @IBAction func textFieldEditingChanged(sender: UITextField) {
        // swiftlint:disable:next force_unwrapping (since we explicitly check for nil)
        if sender.text != nil && !sender.text!.characters.isEmpty {
            proceedButton.hidden = false
        } else {
            proceedButton.hidden = true
        }
    }

    // MARK: Password correctness processing
    private func processPasswordFromTextField(textField: UITextField) -> Bool {

        if output.passwordIsCorrect(textField.text) {
            passwordTextField.resignFirstResponder()
            router.navigateToMainScreen()
            return true
        } else {
            // ...
            return false
        }
    }
}

extension PasswordViewController: UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        processPasswordFromTextField(textField)
        return true
    }
}

extension PasswordViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        PasswordConfigurator.configure(self)
    }
}
