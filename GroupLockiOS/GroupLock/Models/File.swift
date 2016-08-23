//
//  File.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

struct File: Equatable {

    var contents: Data?
    var encrypted: Bool
    var name: String
    var type: String

    static func == (lhs: File, rhs: File) -> Bool {
        return lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.encrypted == rhs.encrypted
            && lhs.contents == rhs.contents
    }
}

extension File {

    init(_ managedFile: ManagedFile) {
        name = managedFile.name
        encrypted = managedFile.encrypted
        type = managedFile.type
        contents = managedFile.contents
    }
}
