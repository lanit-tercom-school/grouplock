//
//  EncryptedFileConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension EncryptedFileViewController: EncryptedFilePresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension EncryptedFileInteractor: EncryptedFileViewControllerOutput {}

extension EncryptedFilePresenter: EncryptedFileInteractorOutput {}

class EncryptedFileConfigurator {

    // MARK: - Configuration

    static func configure(viewController: EncryptedFileViewController) {
        let router = EncryptedFileRouter()
        router.viewController = viewController

        let presenter = EncryptedFilePresenter()
        presenter.output = viewController

        let interactor = EncryptedFileInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
