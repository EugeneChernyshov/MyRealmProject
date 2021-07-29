//
//  FilmsGenresModel.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 20.07.2021.
//

import Foundation

//struct Genres: Codable {
//
//    var name: String
//
//    init(with genreDictionary: [String: Any]) {
//        name = genreDictionary["name"] as? String ?? ""
//    }
//
//}

// MARK: - FilmGenresModel
struct FilmGenresModel: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    init(with genreDictionary: [String: Any]) {
        id = genreDictionary["id"] as? Int ?? 0
        name = genreDictionary["name"] as? String ?? ""
    }
}

