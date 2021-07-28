//
//  Constants.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 28.07.2021.
//

import Foundation

struct Api {
    
    static let BaseUrl = "https://api.themoviedb.org"
    
    static let apiKey = "api_key=a837e864210a43d0d8485e7294324e9e"
    
    static let destination = "/3/genre/movie/list"
    
    static let language = "language=en-US"
    
    static func getFullUrlString(baseURL: String, apiKey: String, destination: String, language: String) -> String {
        
        let urlString = "\(baseURL)" + "\(destination)" + "?" + "\(apiKey)" + "&" + "\(language)"
        return urlString
    }
}
