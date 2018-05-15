//
//  Coalition.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import Foundation

struct Coalition : Decodable {
    let slug : String
    let color: String
    
    private enum CodingKeys: String, CodingKey {
        case  slug, color
    }
}

