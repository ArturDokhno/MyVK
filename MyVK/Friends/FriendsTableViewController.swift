//
//  TableViewController.swift
//  2l_ArturDokhno
//
//  Created by Артур Дохно on 23.08.2021.
//

import UIKit


class FriendsTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    private let users = [
        friends(image: UIImage(named: "Саске"), name: "Саске"),
        friends(image: UIImage(named: "Сакура"), name: "Сакура")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("some content")
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        users.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userCell = tableView.dequeueReusableCell(
            withIdentifier: "userCell",
            for: indexPath)
        
        let currentUser = users[indexPath.row]
        
        userCell.textLabel?.text = currentUser.name
        userCell.imageView?.image = currentUser.image
        
        return userCell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
        
//        performSegue(
//            withIdentifier: "showFoto",
//            sender: nil)
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
        
        let degree: Double = 90
        let retationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTranform = CATransform3DMakeRotation(retationAngle, 1, 0, 0)
        
        cell.layer.transform = rotationTranform
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.2 * Double(indexPath.row),
            options: .curveEaseInOut,
            animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
}




