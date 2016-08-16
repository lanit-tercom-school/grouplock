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

    func getKeys(min min: Int, max: Int) -> [String] {
        return []
    }

    func encryptImage(image data: NSData, withEncryptionKey key: String) -> NSData? {

        guard let parsedKey = parseKey(key),
              let cgImage = image(from: data) else { return nil }

        let imagePixels = cgImage.pixels
        let encryptedPixels = encrypted(pixels: imagePixels, withKey: parsedKey)
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)

        // swiftlint:disable:next force_unwrapping (because what can possibly go wrong)
        let encryptedImage = CGImage.fromPixels(encryptedPixels, width: width, height: height)!
        return encryptedImage.pngData
    }

    func decryptImage(image data: NSData, withDecryptionKey key: String) -> NSData? {

        guard let parsedKey = parseKey(key),
              let cgImage = image(from: data) else { return nil }

        let imagePixels = cgImage.pixels
        let decryptedPixels = decrypted(pixels: imagePixels, withKey: parsedKey)
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)
        let decryptedImage = CGImage.fromPixels(decryptedPixels, width: width, height: height)
        return decryptedImage?.pngData
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

    private func decrypted(pixels pixels: [Pixel], withKey key: [UInt8]) -> [Pixel] {

        func decrypted(pixel pixel: Pixel, inIndex index: Int, withKey key: [UInt8]) -> Pixel {
            let red = UInt8(((Int(pixel.red)     + Int(key[index % (key.count - 3)    ]))) % 256)
            let green = UInt8(((Int(pixel.green) + Int(key[index % (key.count - 3) + 1]))) % 256)
            let blue = UInt8(((Int(pixel.blue)   + Int(key[index % (key.count - 3) + 2]))) % 256)
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

        func encrypted(pixel pixel: Pixel, inIndex index: Int, withKey key: [UInt8]) -> Pixel {
            let red =   UInt8(((Int(pixel.red)   - Int(key[index % (key.count - 3)    ])) + 256) % 256)
            let green = UInt8(((Int(pixel.green) - Int(key[index % (key.count - 3) + 1])) + 256) % 256)
            let blue =  UInt8(((Int(pixel.blue)  - Int(key[index % (key.count - 3) + 2])) + 256) % 256)
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
