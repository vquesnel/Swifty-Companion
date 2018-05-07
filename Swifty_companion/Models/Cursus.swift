//
//  Cursus.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import Foundation


struct Cursus : Decodable {
    let grade : String?
    let level : Double
    let skills : [Skills]
    
    private enum CodingKeys: String, CodingKey {
        case grade, level, skills
    }
    
}
