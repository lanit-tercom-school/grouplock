//
//  ManagedFile.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import CoreData

class ManagedFile: NSManagedObject {

    convenience init(name: String, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("File", inManagedObjectContext: context)
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        self.name = name
    }

    convenience init(_ file: File, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        self.init(name: file.name, insertIntoManagedObjectContext: context)
        type = file.type
        encrypted = file.encrypted
        contents = file.contents
    }
    
}
