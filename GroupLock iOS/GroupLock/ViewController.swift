//
//  ViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    // MARK: UI elements
    @IBOutlet var enterPasswordLabel: UILabel!
    @IBOutlet var initialPasswordTextField: UITextField!
              let proceedButton = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // MARK: Event handling
    @IBAction func onPasswordTextField(sender: UITextField) {
        showProceedButton(proceedButton)
        proceedButton.addTarget(self, action: #selector(PasswordViewController.onProceedButton), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func onProceedButton(sender: UIButton) {
        // Until password check is implemented, then remove this
        enterPasswordLabel.textColor = UIColor(colorLiteralRed: 0.251, green: 0.643, blue: 0.239, alpha: 1.0)
        
    }
    
    // MARK: Helping Functions
    private func showProceedButton(button: UIButton) {
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor(colorLiteralRed: 0.251, green: 0.643, blue: 0.239, alpha: 1.0)
        button.tintColor = UIColor.whiteColor()
        button.setTitle("I'm not a cheater", forState: UIControlState.Normal)
        view.addSubview(button)
        
        let topConstraint = proceedButton.topAnchor.constraintEqualToAnchor(initialPasswordTextField.bottomAnchor, constant: 15)
        let xAlignmentConstraint = proceedButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let widthConstraint = proceedButton.widthAnchor.constraintEqualToConstant(130)
        NSLayoutConstraint.activateConstraints([topConstraint, xAlignmentConstraint, widthConstraint])
        
    }
}