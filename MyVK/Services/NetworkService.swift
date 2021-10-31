//
//  NetworkService.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 31.10.2021.
//

import UIKit


final class NetworkService {
    private let session = URLSession.shared
    
    private let urlComponent: URLComponents = {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.vk.com"
        return component
    }()
    
    func feachGroups(complection: @escaping ([Group]?) -> Void) {
        var urlComponent = urlComponent.self
        urlComponent.path = "/method/groups.get"
        urlComponent.queryItems = [
            URLQueryItem(
                name: "access_token",
                value: Singleton.shared.token),
            URLQueryItem(
                name: "v",
                value: "5.131"),
            URLQueryItem(
                name: "user_id",
                value: "\(Singleton.shared.userID)"),
            URLQueryItem(
                name: "extended",
                value: "1"),
            URLQueryItem(
                name: "fields",
                value: "photo_200")
        ]
        
        guard let url = urlComponent.url else { return }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5.0
        
        session.dataTask(with: request) { data, urlResponse, error in
            guard error == nil
            , let data = data
            else { return }
            do {
                let groups = try JSONDecoder().decode(VKResponse<GroupItems>.self, from: data)
                DispatchQueue.main.async {
                    complection(groups.response.items)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
