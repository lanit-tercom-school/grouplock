//
//  LibraryDirectoryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 14.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class LibraryDirectoryViewController: UIViewController {

    @IBOutlet var encryptedButton: UIButton!
    @IBOutlet var decryptedButton: UIButton!
    @IBOutlet var loadButton: UIButton!

    private let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext

    @IBAction func onDirectory(_ sender: UIButton) {
        performSegue(withIdentifier: "toFiles", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIButton,
            let destination = segue.destination as? LibraryViewController {
            var directory: Directory
            switch sender {
            case encryptedButton:
                directory = .Encrypted
            case decryptedButton:
                directory = .Decrypted
            default:
                directory = .Encrypted
            }
            destination.directory = directory
        }
    }

    // MARK: - Loading a new file using UIImagePickerController

    @IBAction func onLoad(_ sender: UIButton) {

        presentImagePicker()
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismiss(animated: true, completion: nil)

        // swiftlint:disable:next force_cast (since the value for this key is an instance of NSURL)
        let fileURL = info[UIImagePickerControllerReferenceURL] as! URL

        if let loadedFile = FileManager.sharedInstance.createFileFromURL(fileURL,
                                                                         withName: "__defaultName",
                                                                         encrypted: false) {

            pickEncryptionStatusAlert(forFile: loadedFile) { (file) in
                self.setFileNameAlert(file) { (file) in
                    self.managedObjectContext.insert(file)
                    AppDelegate.sharedInstance.saveContext()
                }

            }
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
