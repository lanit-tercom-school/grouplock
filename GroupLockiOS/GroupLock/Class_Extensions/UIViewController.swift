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

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(UIViewController.dismissKeyboard))

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
        albumPicker.navigationBar.isTranslucent = false
        albumPicker.mediaTypes = [kUTTypeImage as String]
        present(albumPicker, animated: true, completion: nil)
    }

    func pickEncryptionStatusAlert(forFile file: ManagedFile, completion: ((ManagedFile) -> Void)?) {
        let actionSheet = UIAlertController(title: nil, message: "What do you to load this file for?",
                                            preferredStyle: .actionSheet)
        let forEncryption = UIAlertAction(title: "Encryption", style: .default) { _ in
            file.encrypted = false
            completion?(file)
        }
        let forDecryption = UIAlertAction(title: "Decryption", style: .default) { _ in
            file.encrypted = true
            completion?(file)
        }
        actionSheet.addAction(forEncryption)
        actionSheet.addAction(forDecryption)

        present(actionSheet, animated: true, completion: nil)
    }

    // TODO: Implement uniqueness check
    func setFileNameAlert(_ file: ManagedFile, completion: ((ManagedFile) -> Void)?) -> Void {
        let nameAlert = UIAlertController(title: "Name", message: "Type a desired name for this file.",
                                          preferredStyle: .alert)
        nameAlert.addTextField(configurationHandler: nil)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            if let name = nameAlert.textFields?.first?.text {
                file.name = name
                completion?(file)
            }
        }

        nameAlert.addAction(action)

        present(nameAlert, animated: false, completion: nil)
    }
}
