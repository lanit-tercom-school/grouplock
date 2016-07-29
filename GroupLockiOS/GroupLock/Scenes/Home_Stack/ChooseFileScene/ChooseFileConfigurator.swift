//
//  ChooseFileConfigurator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ChooseFileViewController: ChooseFilePresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension ChooseFileInteractor: ChooseFileViewControllerOutput {}

extension ChooseFilePresenter: ChooseFileInteractorOutput {}

class ChooseFileConfigurator {
    
    // MARK: - Configuration
    
    static func configure(viewController: ChooseFileViewController) {
        let router = ChooseFileRouter()
        router.viewController = viewController
        
        let presenter = ChooseFilePresenter()
        presenter.output = viewController
        
        let interactor = ChooseFileInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
