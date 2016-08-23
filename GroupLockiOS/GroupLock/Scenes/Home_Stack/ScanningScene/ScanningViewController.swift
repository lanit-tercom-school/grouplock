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
    func displayKeyScan(_ viewModel: Scanning.Keys.ViewModel)
    func displayCameraErrorMessage(_ viewModel: Scanning.CameraError.ViewModel)
}

protocol ScanningViewControllerOutput {
    var captureSession: AVCaptureSession! { get }
    var scannedKeys: [String] { get }
    var metadataOutputObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate? { get }
    func configureCaptureSession(_ request: Scanning.Configure.Request)
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
        interactivePopGestureRecognizerDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBars(hidden: true)
        output.captureSession.startRunning()
        qrCodeFrameLayer = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        setBars(hidden: false)
        navigationController?
            .interactivePopGestureRecognizer?.delegate = interactivePopGestureRecognizerDelegate
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        qrCodeFrameLayer = nil
        output.captureSession.stopRunning()

        super.viewDidDisappear(animated)
    }

    override var prefersStatusBarHidden: Bool { return true }

    private func setBars(hidden: Bool) {
        navigationController?.setNavigationBarHidden(hidden, animated: true)
        tabBarController?.tabBar.isHidden = hidden
    }

    private func configurePreview(_ view: UIView) {

        let previewLayer = AVCaptureVideoPreviewLayer(session: output.captureSession)
        previewLayer?.frame = view.layer.frame
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        (output.metadataOutputObjectsDelegate as? MetadataOutputObjectsDelegate)?.layer = previewLayer
        view.layer.addSublayer(previewLayer!)

        view.subviews.forEach(view.bringSubview(toFront:))
    }


    // MARK: - Display logic

    func displayKeyScan(_ viewModel: Scanning.Keys.ViewModel) {
        output.captureSession.stopRunning()
        keysCounter.text = "\(viewModel.numberOfDifferentKeys)"
        scanOneMoreButton.isEnabled = true
        proceedButton.isEnabled = true

        let frameColor = viewModel.isValidKey ?
            NUISettings.getColor("stroke-color-success", withClass: "DetectedQRCodeFrame") :
            NUISettings.getColor("stroke-color-failure", withClass: "DetectedQRCodeFrame")

        if let layer = qrCodeFrameLayer {
            layer.path = viewModel.qrCodeCGPath
            layer.strokeColor = frameColor?.cgColor
            cameraPreview.layer.setNeedsDisplay()
        } else {
            qrCodeFrameLayer = qrCodeFrameLayer(with: viewModel.qrCodeCGPath, color: frameColor!)
        }
    }

    private func qrCodeFrameLayer(with path: CGPath, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = cameraPreview.layer.frame
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = CGFloat(NUISettings.getFloat("line-width", withClass: "DetectedQRCodeFrame"))
        layer.lineJoin = kCALineJoinRound
        layer.path = path
        return layer
    }

    func displayCameraErrorMessage(_ viewModel: Scanning.CameraError.ViewModel) {
        let alert = UIAlertController(title: viewModel.errorName,
                                      message: viewModel.errorDescription,
                                      preferredStyle: .alert)
        let backAction = UIAlertAction(title: "Back", style: .cancel) { _ in
            self.router.navigateBackToChooseFile()
        }
        alert.addAction(backAction)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Event Handling

    @IBAction func onScanOneMore(_ sender: UIButton) {
        qrCodeFrameLayer = nil
        scanOneMoreButton.isEnabled = false
        output.captureSession.startRunning()
    }

    @IBAction func onBack(_ sender: UIButton) {
        router.navigateBackToChooseFile()
    }
}

extension ScanningViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { return true }
}

extension ScanningViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ScanningConfigurator.configure(self)
    }
}
