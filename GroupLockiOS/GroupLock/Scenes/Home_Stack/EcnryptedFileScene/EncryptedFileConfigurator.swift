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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }
}

extension EncryptedFileInteractor: EncryptedFileViewControllerOutput {}

extension EncryptedFilePresenter: EncryptedFileInteractorOutput {}

class EncryptedFileConfigurator {

    // MARK: - Configuration

    static func configure(_ viewController: EncryptedFileViewController) {
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
