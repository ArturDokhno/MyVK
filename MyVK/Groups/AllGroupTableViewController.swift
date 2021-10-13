//
//  NewCommunitiesTableViewController.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 30.08.2021.
//

import UIKit

class AllGroupTableViewController: UITableViewController {
    
    @IBOutlet var tableViewHeader: AllGroupTableHeader!
    
    let allGroups = [
        Group(image: UIImage(named: "Школа №38"), name: "Школа №38"),
        Group(image: UIImage(named: "Анонимный Сургут"), name: "Анонимный Сургут"),
        Group(image: UIImage(named: "Наш Сургут"), name: "Наш Сургут"),
        Group(image: UIImage(named: "Фитнес клуб"), name: "Фитнес клуб")
    ]
    
    //    var letters = [Character]()
    //    var groups = [Character: [Group]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: "GroupCell",
                bundle: nil),
            forCellReuseIdentifier: "customGroupCell")
        
        tableViewHeader.imageView.image = UIImage(named: "Группы")
        tableViewHeader.imageView.contentMode = .scaleAspectFill
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        allGroups.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "customGroupCell",
                for: indexPath) as? GroupCell
        
        else { return UITableViewCell() }
        
        cell.configure(group: allGroups[indexPath.row])
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
        
        performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        60.0
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
}
