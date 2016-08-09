//
//  ScanningInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//


import AVFoundation

protocol ScanningInteractorInput {
    var captureSession: AVCaptureSession! { get }
    var scannedKeys: Set<String> { get set }
    func configureCaptureSession(request: Scanning.Configure.Request)
}

protocol ScanningInteractorOutput {

}

class ScanningInteractor: NSObject, ScanningInteractorInput {

    var output: ScanningInteractorOutput!

    var captureSession: AVCaptureSession!

    var scannedKeys = Set<String>()

    // MARK: - Business logic

    func configureCaptureSession(request: Scanning.Configure.Request) {

        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

        captureSession = AVCaptureSession()

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch let error as NSError {
            NSLog(error.localizedDescription)
            return
        }

        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
}

extension ScanningInteractor: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [AnyObject]!,
                                                fromConnection connection: AVCaptureConnection!) {
        guard metadataObjects != nil && !metadataObjects.isEmpty else { return }

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            scannedKeys.insert(metadataObject.stringValue)
        }
    }
}
