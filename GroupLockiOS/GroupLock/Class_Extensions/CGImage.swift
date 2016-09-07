//
//  CGImage.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import CoreGraphics
import ImageIO
import MobileCoreServices

extension CGImage {

    func createPixelsBuffer() -> UnsafeMutableBufferPointer<UInt32> {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        let bytesPerPixel = bitsPerPixel / 8
        let bytesPerRow = bytesPerPixel * width
        let data = UnsafeMutablePointer<UInt32>.allocate(capacity: width * height)
        let context = CGContext(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: alphaInfo.rawValue)!
        // swiftlint:disable:previous force_unwrapping (the settings are ok, context is presumably
        // guaranteed to be created)

        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        return UnsafeMutableBufferPointer(start: data, count: width * height)
    }

    func createPNGData() -> Data? {
        return createData(ofType: kUTTypePNG)
    }

    private func createData(ofType type: CFString) -> Data? {
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

    static func createFromPixelsBuffer(_ pixels: UnsafeMutableBufferPointer<UInt32>,
                                       width: Int, height: Int) -> CGImage? {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGImageAlphaInfo.premultipliedLast

        let data = pixels.baseAddress
        let context = CGContext(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * width,
                                space: colorSpace,
                                bitmapInfo: alphaInfo.rawValue)
        return context?.makeImage()
    }
}
