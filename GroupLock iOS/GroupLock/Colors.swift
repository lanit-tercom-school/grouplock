//
//  Colors.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 12/04/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class Colors: NSObject {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func backgroundColor() -> UIColor {
        return UIColorFromRGB(0xe0e8f4) // "Mystic" color
    }
    
    func mainColor() -> UIColor {
        return UIColorFromRGB(0x303d55) // "Biscay" color
    }
    
    func textColor() -> UIColor{
        return UIColor.whiteColor()
    }
    
    func rightPasswordColor() -> UIColor {
        return UIColor(colorLiteralRed: 0.251, green: 0.643, blue: 0.239, alpha: 1.0)
    }
    
    func wrongPasswordColor() -> UIColor {
        return UIColorFromRGB(0xfd3a1c)
    }
    
    func passwordButtonColor() -> UIColor {
        return UIColor(colorLiteralRed: 0.251, green: 0.643, blue: 0.239, alpha: 1.0)
    }
}


