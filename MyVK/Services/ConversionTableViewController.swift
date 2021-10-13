//
//  Conversion TableViewController.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 06.10.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConversionTableViewController: UITableViewController {
    
    var array = [String]()
    
    let url = "http://data.fixer.io/api/latest"
    let key = "a1543ccf3d0c380929f852b1f96a681e"
    let base = "EUR"
    let symbols = "USD, RUB, GBP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param = ["access_key": key,
                     "base": base,
                     "symbols": symbols]
        
        //        getPrice(url:"""
        //                 http://data.fixer.io/api/latest
        //                 ?access_key=a1543ccf3d0c380929f852b1f96a681e
        //                 &base=EUR
        //                 &symbols=USD,RUB
        //                 """)
        
        getPrice(url: url, parameters: param)
    }
    
    func getPrice(url: String, parameters: [String: String]) {
        
        AF.request(url,
                   method: .get,
                   parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    self.title = "\(json["base"])"
                    
                    self.updatePrices(json: json)
                    
                case .failure(let error):
                    print(error)
                }
                
                self.tableView.reloadData()
            }
    }
    
    func updatePrices(json: JSON) {
        
        for (name, price) in json["rates"] {
            
            let curr = ("\(name): \(price)")
            array.append(curr)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            return array.count
        }
    
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "conversionCell",
                for: indexPath)
            
            cell.textLabel?.text = array[indexPath.row]
            
            return cell
        }
    
}
