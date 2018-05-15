//
//  StringTrim.swift
//  Swifty_companion
//
//  Created by victor quesnel on 04/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

extension String
{
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func hexString(hexColor: String) -> UIColor {
        var color : String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (color.hasPrefix("#")) {
            color.remove(at: color.startIndex)
        }
        
        if ((color.count) != 6) {
            return UIColor.white
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: color).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xff0000) >> 16) / 0xff,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 0xff,
            blue: CGFloat(rgbValue & 0x0000FF) / 0xff,
            alpha: CGFloat(1.0)
        )
    }
}
