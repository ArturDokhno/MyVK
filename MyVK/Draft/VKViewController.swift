//
//  VKViewController.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 07.10.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class VKViewController: UIViewController {
    
    var usersList: [String] = []
    
    @IBOutlet var tableViewVkInfo: UITableView!
    @IBOutlet var vkIdText: UITextField!
    @IBAction func getVkInfo(_ sender: Any) {
        
        let url: String = "https://api.vk.com/method/users.get?user_id=\(vkIdText.text!)&v=5.131&access_token=0878fbd70878fbd70878fbd70408016e53008780878fbd769248f4e81ac5d338a69861a"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.usersList.append(json["response"][0]["first_name"].stringValue + " " +
                                      json["response"][0]["last_name"].stringValue + " ID " +
                                      json["response"][0]["id"].stringValue)
                print(self.usersList)
                self.tableViewVkInfo.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewVkInfo.dataSource = self
    }
}

extension VKViewController: UITableViewDataSource {
    
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
        return usersList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellVK", for: indexPath)
        cell.textLabel?.text = usersList[indexPath.row]
            
        return cell
    }

}
