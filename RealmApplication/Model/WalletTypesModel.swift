//
//  WalletTypesModel.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 28.07.2021.
//

import Foundation

// MARK: - WalletModel
struct WalletTypesModel: Codable {
    let walletTypes: [WalletType]
}

// MARK: - WalletType
struct WalletType: Codable {
    let name: String
    let value: Int
    
    init(with genreDictionary: [String: Any]) {
        name = genreDictionary["name"] as? String ?? ""
        value = genreDictionary["value"] as? Int ?? 0
    }
}

