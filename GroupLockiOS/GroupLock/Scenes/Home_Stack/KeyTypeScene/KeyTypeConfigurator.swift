//
//  KeyTypeConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension KeyTypeViewController: KeyTypePresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }
}

extension KeyTypeInteractor: KeyTypeViewControllerOutput {}

extension KeyTypePresenter: KeyTypeInteractorOutput {}

class KeyTypeConfigurator {

    // MARK: - Configuration

    static func configure(_ viewController: KeyTypeViewController) {
        let router = KeyTypeRouter()
        router.viewController = viewController

        let presenter = KeyTypePresenter()
        presenter.output = viewController

        let interactor = KeyTypeInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
