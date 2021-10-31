//
//  GroupCell.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 08.09.2021.
//

import UIKit
import Nuke

class GroupCell: UITableViewCell {
    
    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(group: Group) {
        Nuke.loadImage(with: group.imageURL, into: groupImageView)
        groupNameLabel.text = group.name
    }
}
