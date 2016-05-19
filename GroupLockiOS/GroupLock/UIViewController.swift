//
//  UIViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import MobileCoreServices
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

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePicker() {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.navigationBar.translucent = false
        albumPicker.mediaTypes = [kUTTypeImage as String]
        presentViewController(albumPicker, animated: true, completion: nil)
    }
    
    func pickEncryptionStatusAlert(forFile file: File, completion: ((File) -> Void)?) {
        let actionSheet = UIAlertController(title: nil, message: "What do you to load this file for?",
                                            preferredStyle: .ActionSheet)
        let forEncryption = UIAlertAction(title: "Encryption", style: .Default) { _ in
            file.encrypted = false
            completion?(file)
        }
        let forDecryption = UIAlertAction(title: "Decryption", style: .Default) { _ in
            file.encrypted = true
            completion?(file)
        }
        actionSheet.addAction(forEncryption)
        actionSheet.addAction(forDecryption)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    // TODO: Implement uniqueness check
    func setFileNameAlert(file: File, completion: ((File) -> Void)?) -> Void {
        let nameAlert = UIAlertController(title: "Name", message: "Type a desired name for this file.",
                                          preferredStyle: .Alert)
        nameAlert.addTextFieldWithConfigurationHandler(nil)
        
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            if let name = nameAlert.textFields?.first?.text {
                file.name = name
                completion?(file)
            }
        }
        
        nameAlert.addAction(action)
        
        presentViewController(nameAlert, animated: false, completion: nil)
    }
}