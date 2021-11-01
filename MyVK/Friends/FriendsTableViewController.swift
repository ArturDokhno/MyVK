//
//  TableViewController.swift
//  2l_ArturDokhno
//
//  Created by Артур Дохно on 23.08.2021.
//

import UIKit


class FriendsTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    let friendsService = FriendsGetAPI()
    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: "FriendCell",
                bundle: nil),
            forCellReuseIdentifier: "customFriendCell")
        
        friendsService.getFriends { [weak self] friends in
            guard let friends = friends else { return }
            self?.friends = friends
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            friends.count
        }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "customFriendCell",
                for: indexPath) as? FriendCell
            else { return UITableViewCell()}
            
            cell.configure(friend: friends[indexPath.row])

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
