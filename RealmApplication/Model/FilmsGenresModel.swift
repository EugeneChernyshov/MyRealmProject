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
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([Genre].self, forKey: .genres)
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

