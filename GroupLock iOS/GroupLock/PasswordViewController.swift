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
    //let proceedButton = UIButton(type: UIButtonType.System)
    @IBOutlet weak var proceedButton: UIButton!
    
    let projectColors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = projectColors.mainColor()
        //proceedButton.translatesAutoresizingMaskIntoConstraints = false
        enterPasswordLabel.tintColor = projectColors.wrongPasswordColor()
    }
    
    // MARK: Event handling
    @IBAction func onPasswordTextField(sender: UITextField) {
        proceedButton.hidden = false
        //showProceedButton(proceedButton)
        //proceedButton.addTarget(self, action: #selector(PasswordViewController.onProceedButton), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func onProceedButton(sender: UIButton) {
        // Until password check is implemented, then remove this
        enterPasswordLabel.textColor = projectColors.rightPasswordColor()
        
    }
    
    // MARK: Helping Functions
    //    private func showProceedButton(button: UIButton) {
    //        button.hidden = false
    //        button.frame = CGRectMake(100, 100, 100, 50)
    //        button.backgroundColor = projectColors.passwordButtonColor()
    //        button.tintColor = projectColors.textColor()
    //        button.setTitle("I'm not a cheater", forState: UIControlState.Normal)
    //        view.addSubview(button)
    
    //        let topConstraint = proceedButton.topAnchor.constraintEqualToAnchor(initialPasswordTextField.bottomAnchor, constant: 15)
    //        let xAlignmentConstraint = proceedButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
    //        let widthConstraint = proceedButton.widthAnchor.constraintEqualToConstant(130)
    //        NSLayoutConstraint.activateConstraints([topConstraint, xAlignmentConstraint, widthConstraint])
    
    //    }
    
}