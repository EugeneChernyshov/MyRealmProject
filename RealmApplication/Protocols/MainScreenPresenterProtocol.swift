//
//  MainScreenPresenterProtocol.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 21.07.2021.
//

import Foundation
import UIKit

protocol MainScreenPresenterProtocol {
    
    func fetchDataFromNetwork()
    func saveStringDataToRealm(name: String?)
    func reciveTextDescriptionFromDB() -> String?

}
