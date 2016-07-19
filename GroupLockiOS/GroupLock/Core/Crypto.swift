//
//  Crypto.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreImage

/// Wrapper for the crypto library
class Crypto {
    
    /**
     Forms a request for the crypto library to provide an array of decryption keys.
     
     - parameter min: The minimum amount of keys needed to be applied in order to decrypt a file.
     - parameter max: The overall amount of keys to generate.
     
     - returns: An array of decryption keys constructed by a crypto library.
     */
    static func getKeys(min min: Int, max: Int) -> [String] {
        
        // implementation goes here
        return ["Hello", "World"]
    }
    
    /**
     Forms a request for the crypto library to encrypt given image using given encryption key.
     
     - parameter image: Image to encrypt
     - parameter key:   Encryption key
     
     - returns: Encrypted image
     */
    static func encryptImage(image image: CIImage, withEncryptionKey key: String) -> CIImage {
        
        // implementation goes here
        return image.imageByApplyingOrientation(2)
    }
    
    /// Provides a maximum number of keys that can be generated
    static let maximumNumberOfKeys = 15
}