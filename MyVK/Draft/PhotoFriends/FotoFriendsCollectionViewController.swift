//
//  FotoFriendsCollectionViewController.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 08.09.2021.
//

import UIKit

class FotoFriendsCollectionViewController: UICollectionViewController {
    
    let friendsFoto = [
        FriendsFoto(image: UIImage(named: "Сакура")),
        FriendsFoto(image: UIImage(named: "Саске"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(
                nibName: "CollectionViewCell",
                bundle: nil),
                forCellWithReuseIdentifier: "CollectionViewCell.swift")
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        
        friendsFoto.count
    }
    
    override func collectionView(
        
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "imageCell",
                for: indexPath) as? FotoFriendsCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configure(with: friendsFoto[indexPath.item])
        
        return cell
    }
    
}

