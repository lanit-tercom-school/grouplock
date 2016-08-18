//
//  CryptoFake.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import CoreGraphics
import ImageIO
import MobileCoreServices

class CryptoFake: CryptoWrapperProtocol {

    let maximumNumberOfKeys = 1

    /**
     Creates 120-digit random key and represents it as a String.

     - parameter min: Concrete value does not play a role for now
     - parameter max: Concrete value does not play a role for now

     - precondition: `max` is not greater than `maximumNumberOfKeys` and `min` is not greater than `max`

     - returns: String representation of the key
     */
    func getKeys(min min: Int, max: Int) -> [String] {
        precondition(max <= maximumNumberOfKeys,
                     "Maximum number of keys provided is exceeds the value of maximumNumberOfKeys")
        precondition(min <= max, "min should be less than or equal to max")

        let digitalKey = (0 ..< 40).map { _ in UInt8(arc4random_uniform(256)) }

        return [digitalKey.map { String(format: "%03d", $0) }.reduce("", combine: +)]
    }

    /**
     Encrypts given image with given key.

     Expands the key using linear congruential pseudorandom generator and encrypts the image
     using improved Kasenkov's cipher

     - parameter data: Image data to encrypt
     - parameter key:  Encryption key

     - precondition: `key` is at least 9 digits long.

     - returns: Encrypted data, or `nil` is something went wrong. For example, the key is invalid or the data is
     not image-representable
     */
    func encryptImage(image data: NSData, withEncryptionKey key: String) -> NSData? {

        guard let parsedKey = parseKey(key),
            let cgImage = image(from: data) else { return nil }

        let expandedKey = expand(parsedKey, for: cgImage)

        let imagePixels = cgImage.pixels
        let encryptedPixels = encrypted(pixels: imagePixels, withKey: expandedKey)
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)

        // swiftlint:disable:next force_unwrapping (because what can possibly go wrong)
        let encryptedImage = CGImage.fromPixels(encryptedPixels, width: width, height: height)!
        return encryptedImage.pngData
    }

    /**
     Decrypts given image with given decryption key.

     Expands the key using linear congruential pseudorandom generator and decrypts the image
     using improved Kasenkov's cipher

     - parameter data: Encrypted data
     - parameter key:  Decryption key

     - precondition: `key` is at least 9 digits long.

     - returns: Decrypted data, or `nil` is something went wrong. For example, the key is invalid or the data is
     not image-representable
     */
    func decryptImage(image data: NSData, withDecryptionKey key: String) -> NSData? {

        guard let parsedKey = parseKey(key),
            let cgImage = image(from: data) else { return nil }

        let expandedKey = expand(parsedKey, for: cgImage)

        let imagePixels = cgImage.pixels
        let decryptedPixels = decrypted(pixels: imagePixels, withKey: expandedKey)
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)
        let decryptedImage = CGImage.fromPixels(decryptedPixels, width: width, height: height)
        return decryptedImage?.pngData
    }

    private func expand(key: [UInt8], for image: CGImage) -> [UInt8] {

        let numberOfBytes = CGImageGetHeight(image) * CGImageGetBytesPerRow(image)

        let expandingFactor = numberOfBytes / key.count + 1

        func generateExpansion(for element: UInt8) -> [UInt8] {
            let lcg = LinearCongruentialGenerator(seed: Double(element))
            let expansion: [UInt8] = (0 ..< expandingFactor).map({ _ in return UInt8(lcg.random() * 255) })
            return expansion
        }

        return key.flatMap(generateExpansion)
    }

    private func image(from data: NSData) -> CGImage? {

        let cgDataProvider = CGDataProviderCreateWithCFData(data)
        switch getImageType(from: data) {
        case .Some("JPG"):
            // swiftlint:disable:next force_unwrapping (since we check for type)
            return CGImageCreateWithJPEGDataProvider(cgDataProvider, nil, false, .RenderingIntentDefault)!
        case .Some("PNG"):
            // swiftlint:disable:next force_unwrapping (since we check for type)
            return CGImageCreateWithPNGDataProvider(cgDataProvider, nil, false, .RenderingIntentDefault)!
        default:
            return nil
        }
    }

    private func getImageType(from data: NSData) -> String? {

        var acc: UInt8 = 0
        data.getBytes(&acc, length: 1)

        switch acc {
        case 0xFF: return "JPG"
        case 0x89: return "PNG"
        case 0x47: return "GIF"
        case 0x49, 0x4D: return "TIFF"
        default: return nil
        }
    }

    private func parseKey(key: String) -> [UInt8]? {

        guard !key.characters.isEmpty else { return nil }
        let digits = key.characters.map { String.init($0) }
        var parsedKey = [UInt8](count: digits.count / 3, repeatedValue: 0)
        for i in 0.stride(to: digits.count, by: 3) {
            if let number = UInt8(digits[i] + digits[i + 1] + digits[i + 2]) {
                parsedKey[i / 3] = number
            } else { return nil }
        }
        return parsedKey
    }

    private struct ColorOffsets {
        static let red = 234
        static let green = -132
        static let blue = 17
    }

    private func decrypted(pixels pixels: [Pixel], withKey key: [UInt8]) -> [Pixel] {

        precondition(key.count > 3, "key is too short")

        func decrypted(pixel pixel: Pixel, inIndex index: Int, withKey key: [UInt8]) -> Pixel {

            let _red = Int(pixel.red)     + Int(key[index % (key.count - 3)    ]) + 512 - ColorOffsets.red
            let _green = Int(pixel.green) + Int(key[index % (key.count - 3) + 1]) + 512 - ColorOffsets.green
            let _blue = Int(pixel.blue)   + Int(key[index % (key.count - 3) + 2]) + 512 - ColorOffsets.blue

            let red =   UInt8(_red % 256)
            let green = UInt8(_green % 256)
            let blue =  UInt8(_blue % 256)
            return Pixel(red: red, green: green, blue: blue, alpha: pixel.alpha)
        }

        var decryptedPixels = [Pixel](count: pixels.count,
                                      repeatedValue: Pixel(red: 0, green: 0, blue: 0, alpha: 0))
        for index in 0 ..< decryptedPixels.count {
            decryptedPixels[index] = decrypted(pixel: pixels[index], inIndex: index, withKey: key)
        }
        return decryptedPixels
    }

    private func encrypted(pixels pixels: [Pixel], withKey key: [UInt8]) -> [Pixel] {

        precondition(key.count > 3, "key is too short")

        func encrypted(pixel pixel: Pixel, inIndex index: Int, withKey key: [UInt8]) -> Pixel {

            let _red = Int(pixel.red)     - Int(key[index % (key.count - 3)    ]) + 512 + ColorOffsets.red
            let _green = Int(pixel.green) - Int(key[index % (key.count - 3) + 1]) + 512 + ColorOffsets.green
            let _blue = Int(pixel.blue)   - Int(key[index % (key.count - 3) + 2]) + 512 + ColorOffsets.blue

            let red =   UInt8(_red % 256)
            let green = UInt8(_green % 256)
            let blue =  UInt8(_blue % 256)
            return Pixel(red: red, green: green, blue: blue, alpha: pixel.alpha)
        }

        var encryptedPixels = [Pixel](count: pixels.count,
                                      repeatedValue: Pixel(red: 0, green: 0, blue: 0, alpha: 0))
        for index in 0 ..< encryptedPixels.count {
            encryptedPixels[index] = encrypted(pixel: pixels[index], inIndex: index, withKey: key)
        }
        return encryptedPixels
    }
}
