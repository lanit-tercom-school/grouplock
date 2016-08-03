//
//  ProvideKeyConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ProvideKeyViewController: ProvideKeyPresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension ProvideKeyInteractor: ProvideKeyViewControllerOutput {}

extension ProvideKeyPresenter: ProvideKeyInteractorOutput {}

class ProvideKeyConfigurator {

    // MARK: - Configuration

    static func configure(viewController: ProvideKeyViewController) {
        let router = ProvideKeyRouter()
        router.viewController = viewController

        let presenter = ProvideKeyPresenter()
        presenter.output = viewController

        let interactor = ProvideKeyInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
