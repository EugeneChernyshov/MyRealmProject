//
//  FilmsGenresModel.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 20.07.2021.
//

import Foundation

struct Genres: Codable {

    var name: String
    
    init(with genreDictionary: [String: Any]) {
        name = genreDictionary["name"] as? String ?? ""
    }
    
}
