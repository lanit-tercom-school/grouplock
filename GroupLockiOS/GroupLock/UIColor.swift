//
//  UIColor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        self.init(colorLiteralRed: Float((hex >> 16) & 0xff) / Float(255.0),
                  green: Float((hex >> 8) & 0xff) / Float(255.0),
                  blue: Float((hex >> 0) & 0xff) / Float(255.0),
                  alpha: Float(1.0))
        
    }
    
}