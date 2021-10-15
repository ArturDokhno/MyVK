//
//  RealmHeroDota.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 15.10.2021.
//

import RealmSwift
import UIKit

class RealmHeroDota: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var localized_name: String = ""
    @objc dynamic var primary_attr: String = ""
    @objc dynamic var attack_type: String = ""
    @objc dynamic var legs: Int = 0
    @objc dynamic var img: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override class func indexedProperties() -> [String] {
        ["localized_name", "img" ]
    }
}

extension RealmHeroDota {
    convenience init(hero: HeroStats) {
        self.init()
        self.id = UUID().uuidString
        self.localized_name = hero.localized_name
        self.primary_attr = hero.primary_attr
        self.attack_type = hero.attack_type
        self.legs = hero.legs
        self.img = hero.img
    }
}
