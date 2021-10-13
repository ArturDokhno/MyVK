//
//  TableViewController.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 30.08.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    var myGroups = [Group]() {
        didSet {
            filteredMyGroups = myGroups
        }
    }
    
    var filteredMyGroups = [Group]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            
            guard let allGroupController = segue.source as?
                    AllGroupTableViewController else { return }
            
            if let indexPath =
                allGroupController.tableView.indexPathForSelectedRow {
                
                let group = allGroupController.allGroups[indexPath.row]
                
                if !myGroups.contains(group) {
                    myGroups.append(group)
                    
                    tableView.reloadData()
                }
            }
        }
    }
    
//    override func tableView(
//        _ tableView: UITableView,
//        commit editingStyle: UITableViewCell.EditingStyle,
//        forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: "GroupCell",
                bundle: nil),
            forCellReuseIdentifier: "customGroupCell")
        
        searchBar.delegate = self
        
        tableView.register(
            MyGroupSectionHeader.self,
            forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    /*
     // Kастомный Heater
     override func tableView(
     _ tableView: UITableView,
     viewForHeaderInSection section: Int) -> UIView? {
     
     guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(
     withIdentifier: "sectionHeader") as? MyGroupSectionHeader
     else { return nil }
     
     sectionHeader.contentView.backgroundColor = .systemGray2
     
     return sectionHeader
     }
     */
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        filteredMyGroups.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "customGroupCell",
                for: indexPath) as? GroupCell
        
        else { return UITableViewCell() }
        
        cell.configure(group: filteredMyGroups[indexPath.row])
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true)
        }
        
//        performSegue(
//            withIdentifier: "addGroup",
//            sender: nil)
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
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
        
        "All My Group"
    }
    
}

extension MyGroupTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterGroups(with: searchText)
    }
    
    private func filterGroups(with text: String) {
        
        guard !text.isEmpty else {
            filteredMyGroups = myGroups
            tableView.reloadData()
            return
        }
        
        filteredMyGroups = myGroups.filter {
            $0.name.lowercased().contains(text.lowercased()) }
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
        
        let translationTransform = CATransform3DTranslate(
            CATransform3DIdentity, -500, 400, 0)
        cell.layer.transform = translationTransform
        
        UIView.animate(
            withDuration: 0.2 * Double(indexPath.row),
            delay: 0.2,
            options: .curveEaseInOut,
            animations: {
                cell.layer.transform = CATransform3DIdentity
            })
    }
    
}


