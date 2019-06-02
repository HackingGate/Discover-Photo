//
//  UIColor+Extension.swift
//  Discover-Photo
//
//  Created by ERU on 2019/06/02.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit

extension UIColor {
    /// This is a function that takes a hex string and returns a UIColor.  
    /// (You can enter hex strings with either format: #ffffff or ffffff)
    /// https://stackoverflow.com/a/27203691/4063462
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
