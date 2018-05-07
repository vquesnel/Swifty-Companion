//
//  User.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login : String
    let email : String
    let phone : String?
    let displayName : String
    let location : String?
    let wallet : Int
    let correctionPoint : Int
    let imageUrl : String
    let cursus : [Cursus]
    let campus : [Campus]
    let projects : [Project]
    
    
    
    private enum CodingKeys: String, CodingKey {
        case id, login, email, phone, location, wallet, campus
        case displayName = "displayname"
        case correctionPoint = "correction_point"
        case imageUrl = "image_url"
        case cursus = "cursus_users"
        case projects = "projects_users"
        
    }
}
