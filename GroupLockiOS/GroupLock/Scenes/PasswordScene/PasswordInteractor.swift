//
//  PasswordInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

protocol PasswordInteractorInput {
    func passwordIsCorrect(password: String?) -> Bool
}

protocol PasswordInteractorOutput {

}

class PasswordInteractor: PasswordInteractorInput {

    var output: PasswordInteractorOutput!

    // MARK: - Business logic

    /**
     For now unconditionally returns `true`. Password check to be implemented in the future.

     - parameter password: Password to verify.

     - returns: `true` if password is correct, otherwise `false`.
     */
    func passwordIsCorrect(password: String?) -> Bool {

        return true
    }
}
