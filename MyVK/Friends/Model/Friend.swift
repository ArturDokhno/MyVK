//
//  Frends.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 30.08.2021.
//

import UIKit

struct FriendsJSON: Codable {
    let response: FriendsResponse
}

struct FriendsResponse: Codable {
    let items: [Friend]
}

struct Friend: Codable {
    let id: Int
    let lastName: String
    let photo: String
    let trackCode, firstName: String
    let deactivated: String?
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo = "photo_200"
        case trackCode = "track_code"
        case firstName = "first_name"
        case deactivated
    }
}
