//
//  MetadataOutputObjectsDelegate.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import AVFoundation

class MetadataOutputObjectsDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {

    weak var scanningInteractor: ScanningInteractor?
    var layer: AVCaptureVideoPreviewLayer?

    func captureOutput(captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [AnyObject]!,
                                                fromConnection connection: AVCaptureConnection!) {
        guard metadataObjects != nil && !metadataObjects.isEmpty else { return }
        guard let scanningInteractor = scanningInteractor,
              let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let transformedMetadataObject = layer?.transformedMetadataObjectForMetadataObject(metadataObject)
                as? AVMetadataMachineReadableCodeObject,
              let key = metadataObject.stringValue,
              let corners = transformedMetadataObject.corners as? [CFDictionary] else { return }

        if scanningInteractor.scannedKeys.contains(key) {
            let response = Scanning.Keys.Response(keyScanned: key,
                                                  isNewKey: false,
                                                  qrCodeCorners: corners,
                                                  keys: scanningInteractor.scannedKeys)
            scanningInteractor.output.formatKeyScan(response)
        } else {
            scanningInteractor.scannedKeys.append(key)
            let response = Scanning.Keys.Response(keyScanned: key,
                                                  isNewKey: true,
                                                  qrCodeCorners: corners,
                                                  keys: scanningInteractor.scannedKeys)
            scanningInteractor.output.formatKeyScan(response)
        }
    }
}
