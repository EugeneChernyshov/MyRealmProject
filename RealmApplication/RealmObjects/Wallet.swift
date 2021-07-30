//
//  Wallet.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 28.07.2021.
//

import Foundation
import RealmSwift


class Wallet: Object {
    
    @objc dynamic var type = ""
    @objc dynamic var id = 0
    
//    override class func primaryKey() -> String? {
//         return "type"
//     }
}
