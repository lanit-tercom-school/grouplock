//
//  ViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController/*, UITextFieldDelegate*/ {
    
    // MARK: UI elements
    @IBOutlet var enterPasswordLabel: UILabel!
    @IBOutlet var initialPasswordTextField: UITextField!
    //let proceedButton = UIButton(type: UIButtonType.System)
    @IBOutlet weak var proceedButton: UIButton!
    
    let projectColors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialPasswordTextField.delegate = self
        initialPasswordTextField.becomeFirstResponder()
        hideKeyboardWhenTappedAround()
        initialPasswordTextField.tintColor = projectColors.cursorColor();
        view.backgroundColor = projectColors.mainColor()
        proceedButton.backgroundColor = projectColors.wrongPasswordColor()
        //proceedButton.translatesAutoresizingMaskIntoConstraints = false
        enterPasswordLabel.tintColor = projectColors.wrongPasswordColor()
    }
    
    // MARK: Event handling
    @IBAction func onPasswordTextField(sender: UITextField) {
//        proceedButton.hidden = false
        //showProceedButton(proceedButton)
        proceedButton.addTarget(self, action: #selector(PasswordViewController.onProceedButton), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func onProceedButton(sender: UIButton) {
        // Until password check is implemented, then remove this
        initialPasswordTextField.resignFirstResponder()
        initialPasswordTextField.backgroundColor = projectColors.rightPasswordColor()
        proceedButton.backgroundColor = projectColors.rightPasswordColor()
        enterPasswordLabel.textColor = projectColors.rightPasswordColor()
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        //hide the keyboard
//        initialPasswordTextField.resignFirstResponder()
//        onProceedButton(proceedButton)
//        return true
//    }

    
    @IBAction func textFieldOnChange(sender: UITextField) {
        if sender.text?.characters.count != 0 {
            proceedButton.hidden = false
        } else {
            proceedButton.hidden = true
        }
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