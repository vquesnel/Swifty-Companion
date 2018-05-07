//
//  Projetc.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import Foundation

struct ProjectInfos : Decodable {
    let name : String
    
    private enum CodingKeys: CodingKey, String {
        case name
    }
}

struct Project : Decodable {
    let finalMark : Int?
    let infos : ProjectInfos
    let validated : Bool?
    
    private enum CodingKeys: CodingKey, String {
        case finalMark = "final_mark"
        case infos = "project"
        case validated = "validated?"
        
    }
    
}
