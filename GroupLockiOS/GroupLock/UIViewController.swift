//
//  UIViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import NUI

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        #if swift(>=2.2)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(UIViewController.dismissKeyboard))
        #else
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        #endif
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}