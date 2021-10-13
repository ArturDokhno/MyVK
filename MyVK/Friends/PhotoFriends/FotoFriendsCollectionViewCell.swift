//
//  FotoFriendsCollectionViewCell.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 08.09.2021.
//

import UIKit

class FotoFriendsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var fotoFriend: UIImageView!
    
    func configure(with friendsFoto: FriendsFoto ) {
        fotoFriend.image = friendsFoto.image
    }
    
}
