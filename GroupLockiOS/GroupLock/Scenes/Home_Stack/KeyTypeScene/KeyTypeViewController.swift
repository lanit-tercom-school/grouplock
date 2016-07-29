//
//  KeyTypeViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol KeyTypeViewControllerInput {
    func onKeyType(sender: UIButton)
}

protocol KeyTypeViewControllerOutput {
    var files: [File] { get set }
    var keyType: KeyType { get }
    
    func setKeyType(request: KeyTypeModels.SetType.Request)
}

class KeyTypeViewController: UIViewController, KeyTypeViewControllerInput {
    
    var output: KeyTypeViewControllerOutput!
    var router: KeyTypeRouter!
    
    // MARK: - Event handling
    @IBAction func onKeyType(sender: UIButton) {
        
        assert(sender.titleLabel?.text != nil, "The button title text must be a type of key representation")
        
        let request = KeyTypeModels.SetType.Request(keyName: sender.titleLabel!.text!)
        output.setKeyType(request)
        router.navigateToNumberOfKeysScene()
    }
}

extension KeyTypeViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        KeyTypeConfigurator.configure(self)
    }
}
