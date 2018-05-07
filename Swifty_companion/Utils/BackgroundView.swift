//
//  BackgroundView.swift
//  Swifty_companion
//
//  Created by victor quesnel on 04/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

final class Utils {
    
    static var shared = Utils()
    
    
    func addBackground(image: String) -> UIImageView {
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.image = UIImage(named: image)
        view.clipsToBounds = true
        view.contentMode = UIViewContentMode.scaleAspectFill
        
        return view
    }
    
}
