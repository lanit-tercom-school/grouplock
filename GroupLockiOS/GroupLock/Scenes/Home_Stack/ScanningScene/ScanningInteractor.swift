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
    var scannedKeys: [String] { get }
    var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate! { get }

    func configureCaptureSession(request: Scanning.Configure.Request)
}

protocol ScanningInteractorOutput {
    func formatKeyScan(response: Scanning.Keys.Response)
    func formatCameraError(response: Scanning.CameraError.Response)
}

class ScanningInteractor: NSObject, ScanningInteractorInput {

    var output: ScanningInteractorOutput!
    lazy var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate! = {
        let delegate = MetadataOutputObjectsDelegate()
        delegate.scanningInteractor = self
        return delegate
    }()

    var captureSession: AVCaptureSession!

    var scannedKeys = [String]()

    // MARK: - Business logic

    func configureCaptureSession(request: Scanning.Configure.Request) {

        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        captureSession = AVCaptureSession()

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch let error as NSError {
            output.formatCameraError(Scanning.CameraError.Response(error: error))
            return
        }

        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        // swiftlint:disable:next force_cast (since documentaion says it is array of strings)
        if (captureMetadataOutput.availableMetadataObjectTypes as! [String]).contains(AVMetadataObjectTypeQRCode) {
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }

        captureMetadataOutput.setMetadataObjectsDelegate(metadataOutputObjectsDelegate,
                                                         queue: dispatch_get_main_queue())
    }
}
