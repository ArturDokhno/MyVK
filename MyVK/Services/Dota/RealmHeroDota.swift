//
//  RealmHeroDota.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 15.10.2021.
//

import RealmSwift
import UIKit
//@Persisted
class RealmHeroDota: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted(indexed: true) var localized_name: String = ""
    @Persisted var primary_attr: String = ""
    @Persisted var attack_type: String = ""
    @Persisted var legs: Int = 0
    @Persisted var img: String = ""
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
