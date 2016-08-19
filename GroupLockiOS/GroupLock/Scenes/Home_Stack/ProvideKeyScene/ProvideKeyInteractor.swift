//
//  ProvideKeyInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

protocol ProvideKeyInteractorInput {
    var files: [File] { get set }
    var numberOfKeys: (Int, Int) { get set }

    func getKeys(_ request: ProvideKey.Configure.Request)
}

protocol ProvideKeyInteractorOutput {
    func createQRCodes(_ response: ProvideKey.Configure.Response)

}

class ProvideKeyInteractor: ProvideKeyInteractorInput {

    var output: ProvideKeyInteractorOutput!

    var files: [File] = []

    var cryptoLibrary: CryptoWrapperProtocol = Crypto()

    // MARK: - Business logic

    var numberOfKeys = (1, 1)

    func getKeys(_ request: ProvideKey.Configure.Request) {

        let keys = cryptoLibrary.getKeys(min: numberOfKeys.0, max: numberOfKeys.1)

        let response = ProvideKey.Configure.Response(decryptionKeys: keys)

        output.createQRCodes(response)
    }
}
