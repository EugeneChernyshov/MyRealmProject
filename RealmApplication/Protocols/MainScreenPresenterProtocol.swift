//
//  MainScreenPresenterProtocol.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 21.07.2021.
//

import Foundation
import UIKit

protocol MainScreenPresenterProtocol {
    
    func fetchWalletData()
    func fetchGenresData()
    func saveGenresData(stringData: String?)
    func saveWalletTypesData(stringData: String?)
    func getGenresData() -> String?
    func getWalletTypesData() -> String?

}
