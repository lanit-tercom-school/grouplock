//
//  ProcessedFileConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 22.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ProcessedFileViewController: ProcessedFilePresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }
}

extension ProcessedFileInteractor: ProcessedFileViewControllerOutput {}

extension ProcessedFilePresenter: ProcessedFileInteractorOutput {}

class ProcessedFileConfigurator {

    // MARK: - Configuration

    static func configure(_ viewController: ProcessedFileViewController) {
        let router = ProcessedFileRouter()
        router.viewController = viewController

        let presenter = ProcessedFilePresenter()
        presenter.output = viewController

        let interactor = ProcessedFileInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
