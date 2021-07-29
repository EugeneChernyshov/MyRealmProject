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
 
    func getAllGenres(completion: (([Genre]) -> Void)?) {
        AF.request(MovieApi.getFullUrlString(baseURL: MovieApi.BaseUrl, apiKey: MovieApi.apiKey, destination: MovieApi.destination, language: MovieApi.language), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response
        { (responseData) in
            guard let data = responseData.data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArray = jsonResponse as? [String: Any], let movieGenres = jsonArray["genres"] as? [[String: Any]] else { return }
                var genres = [Genre]()
             movieGenres.forEach({ genres.append(Genre(with: $0)) })
                completion?(genres)
            } catch {
                print("Error decoding == \(error)")
            }
        }
    }
    
    func getAllWalletTypes(completion: (([WalletType]) -> Void)?) {
        AF.request(WalletApi.getFullUrlString(baseURL: WalletApi.BaseUrl, destination: WalletApi.destination), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response
        { (responseData) in
            guard let data = responseData.data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArray = jsonResponse as? [String: Any], let walletTypes = jsonArray["walletTypes"] as? [[String: Any]] else { return }
                var types = [WalletType]()
             walletTypes.forEach({ types.append(WalletType(with: $0)) })
                completion?(types)
            } catch {
                print("Error decoding == \(error)")
            }
        }
    }
}
