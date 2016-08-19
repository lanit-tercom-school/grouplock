//
//  Pixel.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import CoreGraphics
import ImageIO
import MobileCoreServices

struct Pixel {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var alpha: UInt8
}

extension CGImage {

    var pixels: [Pixel] {

        let context = bitmapContext!
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(self, in: rect)
        
        let data = context.data!.assumingMemoryBound(to: UInt8.self)

        func pixel(in index: Int) -> Pixel {
            let offset = 4 * index
            let alpha = data[offset]
            let red = data[offset + 1]
            let green = data[offset + 2]
            let blue = data[offset + 3]
            return Pixel(red: red, green: green, blue: blue, alpha: alpha)
        }

        return (0 ..< width * height).map(pixel)
    }

    var bitmapContext: CGContext? {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGImageAlphaInfo.premultipliedFirst
        let bytesPerPixel = bitsPerPixel / 8
        let bytesPerRow = bytesPerPixel * width
        return CGContext(data: nil,
                         width: width,
                         height: height,
                         bitsPerComponent: bitsPerComponent,
                         bytesPerRow: bytesPerRow,
                         space: colorSpace,
                         bitmapInfo: alphaInfo.rawValue)
    }

    var pngData: Data? { return getData(ofType: kUTTypePNG) }

    private func getData(ofType type: CFString) -> Data? {
        let data = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(data, type, 1, nil) else {
            return nil
        }

        CGImageDestinationAddImage(imageDestination, self, nil)

        if CGImageDestinationFinalize(imageDestination) {
            return data as Data
        }

        return nil
    }

    static func fromPixels(_ pixels: [Pixel], width: Int, height: Int) -> CGImage? {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGImageAlphaInfo.premultipliedFirst
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width

        let bitmap = UnsafeMutablePointer<UInt8>.allocate(capacity: bytesPerRow * height)

        for pixelIndex in 0 ..< pixels.count {
            bitmap[bytesPerPixel * pixelIndex] = pixels[pixelIndex].alpha
            bitmap[bytesPerPixel * pixelIndex + 1] = pixels[pixelIndex].red
            bitmap[bytesPerPixel * pixelIndex + 2] = pixels[pixelIndex].green
            bitmap[bytesPerPixel * pixelIndex + 3] = pixels[pixelIndex].blue
        }

        let context = CGContext(data: bitmap,
                                            width: width,
                                            height: height,
                                            bitsPerComponent: 8,
                                            bytesPerRow: bytesPerRow,
                                            space: colorSpace,
                                            bitmapInfo: alphaInfo.rawValue)

        let image = context?.makeImage()
        bitmap.deinitialize(count: bytesPerRow * height)
        bitmap.deallocate(capacity: bytesPerRow * height)

        return image
    }
}
