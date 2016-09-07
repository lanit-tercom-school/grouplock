//
//  QRCode.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

/// This structure provides an easy way to generate QR-codes from binary data or strings.
struct QRCode {

    private var data: Data

    private var outputImage: CIImage

    /**
     Creates and returns QR-code for this specific data.

     - parameter data: Binary data from which a QR-code should be generated.

     - returns: `nil` if QR-code generation failed.
     */
    init?(data: Data) {

        guard let filter = CIFilter(name: "CIQRCodeGenerator",
                                    withInputParameters: [
                                        "inputMessage" : data,
                                        "inputCorrectionLevel" : "Q"]),
            let outputImage = filter.outputImage else { return nil }

        self.outputImage = outputImage
        self.data = data
    }

    /**
     Creates and returns QR-code for this string.

     - parameter string: A string from which a QR-code should be generated

     - returns: `nil` if QR-code generation failed.
     */
    init?(string: String) {
        guard let data = string.data(using: String.Encoding.isoLatin1,
                                                  allowLossyConversion: false) else { return nil }

        self.init(data: data)
    }

    /**
     Provides an image representation of a QR-code as a CIImage object.

     - parameter width: Width of the square image in pixels.

     - returns: An image representation of a QR-code as a CIImage object.
     */
    func createCIImage(width: CGFloat) -> CIImage {

        let scale = width / outputImage.extent.width
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)

        return outputImage.applying(scaleTransform)
    }

    /**
     Provides an image representation of a QR-code as a CGImage object.

     - parameter width: Width of the square image in pixels.

     - returns: An image representation of a QR-code as a CGImage object.
     */
    func createCGImage(width: CGFloat) -> CGImage {

        let ciImage = createCIImage(width: width)
        let context = CIContext()

        // swiftlint:disable:next force_unwrapping (what can possibly go wrong)
        return context.createCGImage(ciImage, from: ciImage.extent)!
    }

    /**
     Provides an image representation of a QR-code as a UIImage object.

     - parameter width: Width of the square image in pixels.

     - returns: An image representation of a QR-code as a UIImage object.
     */
    func createUIImage(width: CGFloat) -> UIImage {
        return UIImage(ciImage: createCIImage(width: width))
    }
}
