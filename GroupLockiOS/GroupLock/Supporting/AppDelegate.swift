//
//  AppDelegate.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData
import JSQCoreDataKit
import NUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// Provides a singleton object of an application delegate
    static var sharedInstance = AppDelegate()

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
            if let projectDirectory = NSProcessInfo().environment["PROJECT_DIR"] {
                NUISettings.setAutoUpdatePath("\(projectDirectory)/GroupLock/UI.nss")
            }
        #endif

        NUISettings.initWithStylesheet("UI")


        self.window?.backgroundColor = UIColor.whiteColor()
        return true
    }


    // MARK: - Core Data stack

    lazy var coreDataStack: CoreDataStack! = {

        let bundle = NSBundle.mainBundle()
        let model = CoreDataModel(name: "GroupLock", bundle: bundle)
        let factory = CoreDataStackFactory(model: model)

        var stack: CoreDataStack?
        factory.createStack(onQueue: nil) { (result) in
            switch result {
            case .success(let s):
                stack = s
            case .failure(let e):
                print("Error: \(e)")
                abort()
            }
        }
        return stack
    }()

    var managedObjectModel: NSManagedObjectModel {
        return self.coreDataStack.model.managedObjectModel
    }

    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        return self.coreDataStack.storeCoordinator
    }

    var managedObjectContext: NSManagedObjectContext {
        return self.coreDataStack.mainContext
    }

    func saveContext() {
        JSQCoreDataKit.saveContext(coreDataStack.mainContext)
    }
}
