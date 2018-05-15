//
//  RequestService.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

final class RequestService {
    
    static let shared = RequestService()
    private let cache = NSCache<NSString, UIImage>()
    
    func get<T: Decodable>(req: URLRequest, for type: T.Type, completion: @escaping(T?) -> Void) {
        URLSession.shared.dataTask(with: req) { data, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                print("DataService : \(String(describing: err))")
                return
            }
            guard let getData = data else {
                DispatchQueue.main.async { completion(nil) }
                print("DataService : Data Not Recieved from url --> \(req)")
                return
            }
            guard let JSONData = try? JSONDecoder().decode(T.self, from: getData) else {
                DispatchQueue.main.async { completion(nil) }
                print("DataService : Fetching From Data to Model \(T.self) failed")
                return
            }
            DispatchQueue.main.async { completion(JSONData) }
            }.resume()
    }
    
    func imageDownloader(url: String, completion: @escaping(UIImage?) -> Void) {
        guard let req = URL(string: url) else { return }
        let qos = DispatchQoS.background.qosClass
        
        if let cached = cache.object(forKey: NSString(string: url)) { completion(cached); return }
        
        DispatchQueue.global(qos: qos).async { [unowned self] in
            guard let data = try? Data(contentsOf: req), let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                print("DataService : Failed to Build Image from Data")
                return
            }
            self.cache.setObject(image, forKey: NSString(string: url))
            DispatchQueue.main.async { completion(image) }
        }
    }
    
}
