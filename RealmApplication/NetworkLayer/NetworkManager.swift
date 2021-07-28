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
 
    func getAllGenres(completion: (([Genres]) -> Void)?) {
        AF.request(Api.getFullUrlString(baseURL: Api.BaseUrl, apiKey: Api.apiKey, destination: Api.destination, language: Api.language), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response
        { (responseData) in
            guard let data = responseData.data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArray = jsonResponse as? [String: Any], let movieGenres = jsonArray["genres"] as? [[String: Any]] else { return }
                var genres = [Genres]()
             movieGenres.forEach({ genres.append(Genres(with: $0)) })
                completion?(genres)
            } catch {
                print("Error decoding == \(error)")
            }
        }
    }
}
