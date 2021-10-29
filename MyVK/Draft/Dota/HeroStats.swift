//
//  HeroStats.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 10.10.2021.
//

import Foundation

struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}
