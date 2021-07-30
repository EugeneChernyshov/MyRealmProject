//
//  Item.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 20.07.2021.
//

import Foundation
import RealmSwift

@objcMembers
class Item: Object {
    
    @objc dynamic var name: String?
    
//    override class func primaryKey() -> String? {
//         return "name"
//     }
}
