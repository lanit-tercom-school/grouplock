//
//  ScanningViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 09.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScanningViewControllerInput {

}

protocol ScanningViewControllerOutput {
    var captureSession: AVCaptureSession! { get }
    var scannedKeys: Set<String> { get set }
    func configureCaptureSession(request: Scanning.Configure.Request)
}

class ScanningViewController: UIViewController, ScanningViewControllerInput {

    var output: ScanningViewControllerOutput!
    var router: ScanningRouter!

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.hidden = true
        output.configureCaptureSession(Scanning.Configure.Request())
        configurePreview(view)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        output.captureSession.startRunning()
    }

    override func viewWillDisappear(animated: Bool) {
        output.captureSession.stopRunning()
        super.viewWillDisappear(animated)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func configurePreview(view: UIView) {
        let previewLayer = AVCaptureVideoPreviewLayer(session: output.captureSession)
        previewLayer.frame = view.layer.frame
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        view.layer.addSublayer(previewLayer)
    }


    // MARK: - Display logic


}

extension ScanningViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ScanningConfigurator.configure(self)
    }
}
