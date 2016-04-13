//
//  PasswordViewController.swift
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
    @IBOutlet var proceedButton: UIButton!
    let projectColors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialPasswordTextField.delegate = self
        
        //        initialPasswordTextField.becomeFirstResponder()
        
        hideKeyboardWhenTappedAround()
        
        //        initialPasswordTextField.tintColor = projectColors.cursorColor();
        
        //        view.backgroundColor = projectColors.mainColor()
        
        //        proceedButton.backgroundColor = projectColors.wrongPasswordColor()
        
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        
        //        enterPasswordLabel.tintColor = projectColors.wrongPasswordColor()
    }
    
    // MARK: Event handling
    @IBAction func onPasswordTextField(sender: UITextField) {
        proceedButton.hidden = true
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
    
}