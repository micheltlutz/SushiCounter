//
//  SushiDay.swift
//  SushiCounter
//
//  Created by Michel Anderson Lutz Teixeira on 10/01/19.
//  Copyright © 2019 Michel Anderson Lutz Teixeira. All rights reserved.
//

import RealmSwift

class SushiDay: Object {
    @objc dynamic var count: Int = 0
    @objc dynamic var date: String = ""
    
    override static func primaryKey() -> String? {
        return "date"
    }
}
