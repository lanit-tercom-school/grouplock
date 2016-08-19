//
//  ScanningInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//


import AVFoundation

protocol ScanningInteractorInput: class {
    var captureSession: AVCaptureSession! { get }
    var scannedKeys: [String] { get }
    var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate? { get }

    func configureCaptureSession(_ request: Scanning.Configure.Request)
    func qrCodeCaptured(_ request: Scanning.Keys.Request)
}

protocol ScanningInteractorOutput {
    func formatKeyScan(_ response: Scanning.Keys.Response)
    func formatCameraError(_ response: Scanning.CameraError.Response)
}

class ScanningInteractor: ScanningInteractorInput {

    var output: ScanningInteractorOutput!
    var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate?

    var captureSession: AVCaptureSession!
    var cryptoLibrary: CryptoWrapperProtocol = CryptoFake()

    var scannedKeys = [String]()

    // MARK: - Business logic

    func configureCaptureSession(_ request: Scanning.Configure.Request) {

        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
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
                                                         queue: DispatchQueue.main)
    }

    func qrCodeCaptured(_ request: Scanning.Keys.Request) {

        let key = request.keyScanned
        let corners = request.qrCodeCorners

        if !cryptoLibrary.validatePart(key) || scannedKeys.contains(key) {
            let response = Scanning.Keys.Response(keyScanned: key,
                                                  isValidKey: false,
                                                  qrCodeCorners: corners,
                                                  keys: scannedKeys)
            output.formatKeyScan(response)
        } else {
            scannedKeys.append(key)
            let response = Scanning.Keys.Response(keyScanned: key,
                                                  isValidKey: true,
                                                  qrCodeCorners: corners,
                                                  keys: scannedKeys)
            output.formatKeyScan(response)
        }
    }
}
