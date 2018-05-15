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
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
