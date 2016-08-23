//
//  NumberOfKeysInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

protocol NumberOfKeysInteractorInput {
    var numberOfKeys: Int { get }
    var files: [File] { get }
}

protocol NumberOfKeysInteractorOutput {

}

class NumberOfKeysInteractor: NumberOfKeysInteractorInput {

    var output: NumberOfKeysInteractorOutput!

    var cryptoLibrary: CryptoWrapperProtocol = CryptoFake()

    // MARK: - Business logic

    var numberOfKeys: Int { return cryptoLibrary.maximumNumberOfKeys }

    var files: [File] = []
}
