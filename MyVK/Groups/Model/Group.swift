//
//  Communities.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 30.08.2021.
//

import UIKit

struct VKResponse<T: Codable>: Codable {
    let response: T
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct GroupItems: Codable {
    let items: [Group]
}

struct Group {
    let id: Int
    let name: String
    let imageURL: String
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "photo_200"
    }
}
