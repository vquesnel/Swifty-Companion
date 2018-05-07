//
//  Skills.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import Foundation

struct Skills : Decodable {
    let name : String?
    let level : Double
    
    private enum CodingKeys: String, CodingKey {
        case name, level
    }
    
}
