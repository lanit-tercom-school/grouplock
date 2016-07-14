//
//  ViewFileViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 16.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class ViewFileViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var correspondingFile: File!
    
    override func viewDidLoad() {
        
        navigationItem.title = correspondingFile.name
        
        guard let contents = correspondingFile.contents else {
            return
        }
        imageView.image = UIImage(data: contents)
    }
    
}
