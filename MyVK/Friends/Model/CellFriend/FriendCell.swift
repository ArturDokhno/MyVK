//
//  FriendCell.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 01.11.2021.
//

import UIKit
import Nuke

class FriendCell: UITableViewCell {
    
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(friend: Friend) {
        Nuke.loadImage(with: friend.photo, into: friendImageView)
        friendNameLabel.text = friend.fullName
    }
    
}
