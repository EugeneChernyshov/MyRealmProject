//
//  NetworkManager.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 20.07.2021.
//

import Foundation
import Alamofire

class Networking {
    
    static let shared = Networking()
    
    func fetch<T: Decodable>(from: URL, decodable: T.Type, completion: @escaping (_ details: T) -> Void) {
        AF.request(from, method: .get).responseJSON { response in
            guard let result = response.data else { return }
            do {
                let data = try JSONDecoder().decode(T.self, from: result)
                completion(data)
            } catch let error as NSError {
                print("ERROR : \(error)")
            }
        }
    }
}

