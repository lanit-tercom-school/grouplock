//
//  PasswordConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension PasswordViewController: PasswordPresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension PasswordInteractor: PasswordViewControllerOutput {}

extension PasswordPresenter: PasswordInteractorOutput {}

class PasswordConfigurator {

    // MARK: - Configuration

    static func configure(viewController: PasswordViewController) {
        let router = PasswordRouter()
        router.viewController = viewController

        let presenter = PasswordPresenter()
        presenter.output = viewController

        let interactor = PasswordInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
