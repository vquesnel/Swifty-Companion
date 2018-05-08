//
//  RequestService.swift
//  Swifty_companion
//
//  Created by victor quesnel on 04/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//


import Foundation

struct Token : Decodable {
    var key : String?
    var type : String?
    var expires : Int?
    
    private enum CodingKeys : String, CodingKey {
        case key = "access_token"
        case type = "token_type"
        case expires = "expires_in_seconds"
    }
}

final class APIServices {
    
    let host = "https://api.intra.42.fr/v2"
    let uid = "c1587bd0c060932c36861cbe32ed99d817f76ebcb66803b1c584af8558e97d1e"
    let secret = "be8b7273d48e16de2ffe6931e75aacb94bd7f8e70e9d698f3457bfa51b0f14a7"
    var token : Token?
    static var shared = APIServices()
    
    
    func createRequest(for route: String) -> URLRequest? {
        guard let url = URL(string: "\(host)\(route)") else { return nil }
        check_token()
        guard let token = token?.key else { return nil }
        print("token ---> \(token)")
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getToken(completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: "\(host)/oauth/token") else { completion(false); return }
        
        let body = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        
        RequestService.shared.get(req: request, for: Token.self) { data in
            self.token = data
            completion(true)
        }
    }
    
    func check_token() {
        guard let url = URL(string: "\(host)/oauth/token/info") else { return }
        var request = URLRequest(url: url)
        guard let token = token?.key else { return  }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        RequestService.shared.get(req: request, for: Token.self) { data in
            if var data = data {
                data.expires = 0
                if (data.expires == 0) {
                    self.getToken(){ _ in }
                }
            }
        }
    }
}
