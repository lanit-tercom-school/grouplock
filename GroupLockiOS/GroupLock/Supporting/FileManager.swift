//
//  FileManager.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreData
import JSQCoreDataKit
import Photos

/// FileManager object represents a singleton for imitating file system structure for Library.
class FileManager: NSObject {

    /// Provides a singleton object of a file manager.
    static let sharedInstance = FileManager()

    private override init() {}

    private var context: NSManagedObjectContext {
        return AppDelegate.sharedInstance.managedObjectContext
    }

    /**
     Executes a request for all the files contained in `directory` and returns an array of them.

     - parameter directory: The directory we want to get files contained in.

     - returns: An array of files.
     */
    func files(insideDirectory directory: Directory) -> [ManagedFile] {
        let fetchRequest = NSFetchRequest<ManagedFile>(entityName: "File")
        switch directory {
        case .Encrypted:
            fetchRequest.predicate = NSPredicate(format: "encrypted == true")
        case .Decrypted:
            fetchRequest.predicate = NSPredicate(format: "encrypted == false")
        }

        var files: [ManagedFile] = []

        if #available(iOS 10.0, *) {

            context.performAndWait {
                do {
                    files = try fetchRequest.execute()
                } catch {
                    print(error)
                    abort()
                }
            }
        } else {

            do {
                files = try context.fetch(fetchRequest)
            } catch {
                print(error)
                abort()
            }
        }

        return files
    }

    /**
     Creates NSManagedObject file.

     - returns: Created file
     */
    func createFile(_ name: String, type: String, encrypted: Bool, contents: Data?) -> ManagedFile? {
        guard let entity = NSEntityDescription.entity(forEntityName: "File",
                                                             in: context) else {
            return nil
        }

        let file = ManagedFile(entity: entity, insertInto: nil)
        file.name = name
        file.type = type
        file.encrypted = encrypted
        file.contents = contents
        return file
    }

    func createFileFromURL(_ url: URL, withName name: String, encrypted: Bool) -> ManagedFile? {
        let fileType = url.pathExtension
        let data = getImageContentsForURL(url)
        return createFile(name, type: fileType, encrypted: encrypted, contents: data)
    }

    private func getImageContentsForURL(_ url: URL) -> Data? {

        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        if let asset = fetchResult.firstObject {
            var data: Data?
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestImageData(for: asset, options: options) {
                (imageData, _, _, _) in
                data = imageData
            }
            return data
        }
        return nil
    }
}
