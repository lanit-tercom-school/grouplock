//
//  MetadataOutputObjectsDelegate.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import AVFoundation

protocol MetadataOutputObjectsDelegateOutput {
    func qrCodeCaptured(_ request: Scanning.Keys.Request)
}

class MetadataOutputObjectsDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {

    weak var output: ScanningInteractorInput?
    var layer: AVCaptureVideoPreviewLayer?

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                                                from connection: AVCaptureConnection!) {
        guard metadataObjects != nil && !metadataObjects.isEmpty else { return }
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let transformedMetadataObject = layer?.transformedMetadataObject(for: metadataObject)
                as? AVMetadataMachineReadableCodeObject,
              let key = metadataObject.stringValue,
              let corners = transformedMetadataObject.corners as? [CFDictionary] else { return }

        output?.qrCodeCaptured(Scanning.Keys.Request(keyScanned: key, qrCodeCorners: corners))
    }
}
