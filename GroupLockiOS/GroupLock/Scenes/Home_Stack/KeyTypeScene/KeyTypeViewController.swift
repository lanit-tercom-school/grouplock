//
//  KeyTypeViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 21.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class KeyTypeViewController: UIViewController {

    var files: [ManagedFile]?
    
    private var keyTypes = Set<KeyType>()
            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    @IBAction func onKeyType(sender: UIButton) {
        let keyTypeDictionary = ["QR-CODE" : KeyType.QRCode]
        
        if sender.selected {
            sender.selected = false
            if let deselectedKeyType = keyTypeDictionary[sender.titleLabel?.text ?? "?"] {
                keyTypes.remove(deselectedKeyType)
            }
        } else {
            sender.selected = true
            if let selectedKeyType = keyTypeDictionary[sender.titleLabel?.text ?? "?"] {
                keyTypes.insert(selectedKeyType)
            }
        }
        
    }
}
