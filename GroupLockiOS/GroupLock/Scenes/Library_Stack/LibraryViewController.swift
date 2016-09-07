//
//  LibraryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class LibraryViewController: UITableViewController {

    /// Current directory's contents displayed
    var directory = Directory.Encrypted

    /// Current list of files displayed on the screen
    private var files: [ManagedFile] {
        // FIXME: This causes a lag when entering this screen.
        // This property must be stored and has to be set in the background.
        return FileManager.sharedInstance.files(insideDirectory: directory)
    }

    private let managedObjectContext = AppDelegate.sharedInstance.managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = directory.rawValue
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }


    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell",
                                                               for: indexPath) as! FileTableViewCell
        // swiftlint:disable:previous force_cast (since this tableView uses instances of this class as cells)

        cell.correspondingFile = files[indexPath.row]
        cell.title.text = files[indexPath.row].name
        cell.type.text = files[indexPath.row].type


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {

    }

    // MARK: - Loading a new file using UIImagePickerController

    @IBAction func onLoad(_ sender: UIBarButtonItem) {

        presentImagePicker()
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismiss(animated: true, completion: nil)

        // swiftlint:disable:next force_cast (since the value for this key contains an instance of NSURL)
        let fileURL = info[UIImagePickerControllerReferenceURL] as! URL

        // Create a new file with some default settings
        if let loadedFile = FileManager.sharedInstance.createFileFromURL(fileURL, withName: "__defaultName",
                                                                         encrypted: false) {

            // Depending on which direcrory we're in, put the file into it
            switch directory {
            case .Decrypted:
                loadedFile.encrypted = false
            case .Encrypted:
                loadedFile.encrypted = true
            }
            setFileNameAlert(loadedFile) { (file) in
                self.managedObjectContext.insert(file)
                AppDelegate.sharedInstance.saveContext()
                self.tableView.reloadData()
            }
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewFile" {
            guard let cell = sender as? FileTableViewCell,
                let destination = segue.destination as? ViewFileViewController else {
                return
            }
            destination.correspondingFile = cell.correspondingFile
        }
    }
}
