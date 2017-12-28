//
//  Item.swift
//  ColorBall
//
//  Created by Laurens-Art Ramsenthaler on 20.07.17.
//  Copyright © 2017 Laurens-Art Ramsenthaler. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    dynamic var id: Int = 0
    dynamic var using: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


