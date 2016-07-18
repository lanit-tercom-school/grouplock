//
//  File.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

struct File: Equatable {
    
    var contents: NSData?
    var encrypted: Bool
    var name: String
    var type: String
    
    init(_ managedFile: ManagedFile) {
        name = managedFile.name
        encrypted = managedFile.encrypted
        type = managedFile.type
        contents = managedFile.contents
    }
}

func ==(lhs: File, rhs: File) -> Bool {
    return lhs.contents == rhs.contents
}
