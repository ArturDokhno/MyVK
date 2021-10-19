//
//  DotaViewController.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 10.10.2021.
//

import UIKit
import RealmSwift

class DotaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var heroes = [HeroStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {

        let url = URL(string: "https://api.opendota.com/api/heroStats")

        URLSession.shared.dataTask(with: url!) { data, response, error in

            if error == nil {
                do {
                self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)

                    let realmHeros = self.heroes.map { RealmHeroDota(hero: $0)}
                    try RealmService.save(items: realmHeros)

                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON error")
                }
            }
        }.resume()
    }
    
}

