//
//  TableViewController.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 30.08.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    private let networkService = NetworkService()
    
    
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
        
        networkService.feachGroups { [weak self] groups in
            guard let groups = groups else { return }
            self?.myGroups = groups
        }
    }
    
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
            
            do { tableView.deselectRow(
                at: indexPath,
                animated: true)
            }
        }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            60.0
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
