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
    
    private var baseURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=a837e864210a43d0d8485e7294324e9e&language=en-US"
 
    func getAllGenres(completion: (([Genres]) -> Void)?) {
        AF.request(self.baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response
        { (responseData) in
            guard let data = responseData.data else {return}
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
