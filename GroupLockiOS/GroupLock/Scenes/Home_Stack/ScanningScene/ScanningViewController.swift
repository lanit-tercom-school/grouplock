//
//  ScanningViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import AVFoundation
import NUI

protocol ScanningViewControllerInput {
    func displayKeyScan(viewModel: Scanning.Keys.ViewModel)
    func displayCameraErrorMessage(viewModel: Scanning.CameraError.ViewModel)
}

protocol ScanningViewControllerOutput {
    var captureSession: AVCaptureSession! { get }
    var scannedKeys: [String] { get }
    var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate! { get }
    func configureCaptureSession(request: Scanning.Configure.Request)
}

class ScanningViewController: UIViewController, ScanningViewControllerInput {

    var output: ScanningViewControllerOutput!
    var router: ScanningRouter!

    var cameraPreview: UIView { return view }

    var qrCodeFrameLayer: CAShapeLayer? {
        didSet {
            if let layer = qrCodeFrameLayer {
                cameraPreview.layer.addSublayer(layer)
            } else {
                oldValue?.removeFromSuperlayer()
            }
            cameraPreview.layer.setNeedsDisplay()
        }
    }

    // MARK: - UI Elements

    @IBOutlet var keysCounter: UILabel!
    @IBOutlet var scanOneMoreButton: UIButton!
    @IBOutlet var proceedButton: UIButton!


    // MARK: - View Controller lifecycle

    private var interactivePopGestureRecognizerDelegate: UIGestureRecognizerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        output.configureCaptureSession(Scanning.Configure.Request())
        configurePreview(cameraPreview)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setBars(hidden: true)
        output.captureSession.startRunning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let gestureRecofnizer = navigationController?.interactivePopGestureRecognizer
        interactivePopGestureRecognizerDelegate = gestureRecofnizer?.delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillDisappear(animated: Bool) {
        output.captureSession.stopRunning()
        setBars(hidden: false)
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(animated: Bool) {
        navigationController?
            .interactivePopGestureRecognizer?.delegate = interactivePopGestureRecognizerDelegate
        super.viewDidDisappear(animated)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    private func setBars(hidden hidden: Bool) {
        navigationController?.setNavigationBarHidden(hidden, animated: true)
        tabBarController?.tabBar.hidden = hidden
    }

    private func configurePreview(view: UIView) {

        let previewLayer = AVCaptureVideoPreviewLayer(session: output.captureSession)
        previewLayer.frame = view.layer.frame
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        (output.metadataOutputObjectsDelegate as? MetadataOutputObjectsDelegate)?.layer = previewLayer
        view.layer.addSublayer(previewLayer)

        view.subviews.forEach(view.bringSubviewToFront)
    }


    // MARK: - Display logic

    func displayKeyScan(viewModel: Scanning.Keys.ViewModel) {
        output.captureSession.stopRunning()
        keysCounter.text = "\(viewModel.numberOfDifferentKeys)"
        scanOneMoreButton.enabled = true
        proceedButton.enabled = true

        let frameColor = viewModel.isNewKey ?
            NUISettings.getColor("stroke-color-success", withClass: "DetectedQRCodeFrame") :
            NUISettings.getColor("stroke-color-failure", withClass: "DetectedQRCodeFrame")

        if let layer = qrCodeFrameLayer {
            layer.path = viewModel.qrCodeCGPath
            layer.strokeColor = frameColor.CGColor
            cameraPreview.layer.setNeedsDisplay()
        } else {
            qrCodeFrameLayer = qrCodeFrameLayer(with: viewModel.qrCodeCGPath, color: frameColor)
        }
    }

    private func qrCodeFrameLayer(with path: CGPath, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = cameraPreview.layer.frame
        layer.strokeColor = color.CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineWidth = CGFloat(NUISettings.getFloat("line-width", withClass: "DetectedQRCodeFrame"))
        layer.lineJoin = kCALineJoinRound
        layer.path = path
        return layer
    }

    func displayCameraErrorMessage(viewModel: Scanning.CameraError.ViewModel) {
        let alert = UIAlertController(title: viewModel.errorName,
                                      message: viewModel.errorDescription,
                                      preferredStyle: .Alert)
        let backAction = UIAlertAction(title: "Back", style: .Cancel) { _ in
            self.router.navigateBackToChooseFile()
        }
        alert.addAction(backAction)
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Event Handling

    @IBAction func onScanOneMore(sender: UIButton) {
        qrCodeFrameLayer = nil
        scanOneMoreButton.enabled = false
        output.captureSession.startRunning()
    }

    @IBAction func onBack(sender: UIButton) {
        router.navigateBackToChooseFile()
    }
}

extension ScanningViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool { return true }
}

extension ScanningViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ScanningConfigurator.configure(self)
    }
}
