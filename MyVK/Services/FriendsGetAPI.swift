//
//  FriendsGetAPI.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 01.11.2021.
//

import Foundation
import Alamofire

protocol FriendsGetAPIProtocol {
    func getFriends(complition: @escaping ([Friend]?) -> Void)
}

final class FriendsGetAPI: FriendsGetAPIProtocol {
    
    let baseURL = "https://api.vk.com/method"
    let token = Singleton.shared.token
    let userID = Singleton.shared.userID
    let version = "5.131"
    
    func getFriends(complition: @escaping ([Friend]?) -> Void) {
        
        let method = "/friends.get"
    
        let parameters: Parameters = [
            "user_id": userID,
            "order": "name",
            "fields": "photo_200",
            "access_token": token,
            "v": version,
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            do {
                let friendsJSON = try  JSONDecoder().decode(FriendsJSON.self, from: data)
                let friends: [Friend] = friendsJSON.response.items
                complition(friends)
            } catch {
                print(error)
            }
        }
    }
}




final class FriendsGetAPIProxy: FriendsGetAPIProtocol {
 
    let friendsGetAPI: FriendsGetAPI
    
    init(friendsGetAPI: FriendsGetAPI) {
        self.friendsGetAPI = friendsGetAPI
    }
    
    func getFriends(complition: @escaping ([Friend]?) -> Void) {
        self.friendsGetAPI.getFriends(complition: complition)
        print("Вызван метод getFriends")
    }
    
}
