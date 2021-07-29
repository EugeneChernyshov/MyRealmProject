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
    
    enum CodingKeys: String, CodingKey {
        case walletTypes = "walletTypes"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        walletTypes = try container.decode([WalletType].self, forKey: .walletTypes)
    }
}

// MARK: - WalletType
struct WalletType: Codable {
    let name: String
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(Int.self, forKey: .value)
    }
    
}

