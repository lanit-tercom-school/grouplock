//
//  NumberOfKeysConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension NumberOfKeysViewController: NumberOfKeysPresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension NumberOfKeysInteractor: NumberOfKeysViewControllerOutput {}

extension NumberOfKeysPresenter: NumberOfKeysInteractorOutput {}

class NumberOfKeysConfigurator {

    // MARK: - Configuration

    static func configure(viewController: NumberOfKeysViewController) {
        let router = NumberOfKeysRouter()
        router.viewController = viewController

        let presenter = NumberOfKeysPresenter()
        presenter.output = viewController

        let interactor = NumberOfKeysInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
