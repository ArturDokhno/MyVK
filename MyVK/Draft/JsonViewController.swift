//
//  JsonViewController.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 10.10.2021.
//

import UIKit

class JsonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://api.vk.com/method/users.get?user_id=41631118&v=5.131&access_token=0878fbd70878fbd70878fbd70408016e53008780878fbd769248f4e81ac5d338a69861a"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            
        }.resume()
    }

}
