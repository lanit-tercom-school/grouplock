//
//  Crypto.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreImage

/// Wrapper for the crypto library
protocol CryptoWrapperProtocol {

    /// Provides a maximum number of keys that can be generated
    var maximumNumberOfKeys: Int { get }

    /**
     Forms a request for the crypto library to provide an array of decryption keys.

     - parameter min: The minimum amount of keys needed to be applied in order to decrypt a file.
     - parameter max: The overall amount of keys to generate.
     
     - precondition: `max` is not less than `min` and not greater than `maximumNumberOfKeys`

     - returns: An array of decryption keys constructed by a crypto library.
     */
    func getKeys(min: Int, max: Int) -> [String]

    /**
     Forms a request for the crypto library to validate provided key.

     - parameter key: Key to validate

     - returns: `true` if the key is valid, otherwise `false`
     */
    func validate(key: [String]) -> Bool

    /**
     Forms a request for the crypto library to validate a part of shared secret

     - parameter key: A part of shared secret

     - returns: `true` if the key is valid, otherwise `false`
     */
    func validatePart(_ key: String) -> Bool

    /**
     Forms a request for the crypto library to encrypt given image using given encryption key.

     - parameter image: Image to encrypt
     - parameter key:   Encryption key

     - returns: Encrypted image
     */
    func encrypt(image: Data, withEncryptionKey key: [String]) -> Data?

    /**
     Forms a request for the crypto library ro decrypt given image useing given decryptionKey.

     - parameter image: Image to decrypt
     - parameter key:   Decryption key

     - returns: Decrypted image
     */
    func decrypt(image: Data, withDecryptionKey key: [String]) -> Data?
}

/// Default implementation of the `CryptoWrapperProtocol`
class Crypto: CryptoWrapperProtocol {

    func getKeys(min: Int, max: Int) -> [String] {

        // implementation goes here
        return [Int](1...max).map(String.init)
    }

    func validate(key: [String]) -> Bool {
        return false
    }

    func validatePart(_ key: String) -> Bool {
        return false
    }

    func encrypt(image: Data, withEncryptionKey key: [String]) -> Data? {

        // implementation goes here
        return image
    }

    func decrypt(image: Data, withDecryptionKey key: [String]) -> Data? {

        // implementatiuon goes here
        return image
    }

    let maximumNumberOfKeys = 15
}
