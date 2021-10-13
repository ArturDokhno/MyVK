//
//  FullScreenViewController.swift
//  10l_ArturDokhno
//
//  Created by Артур Дохно on 03.10.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    let countCells = 1
    let identifire = "FullScreenCell"
    var photoGallary: PhotoGallary!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(
            nibName: "FullScreenCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: identifire)
        
        collectionView.performBatchUpdates(nil) { (result) in
            self.collectionView.scrollToItem(
                at: self.indexPath,
                at: .centeredHorizontally,
                animated: false)
        }
    }
}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return photoGallary.images.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifire,
                for: indexPath) as! FullScreenCollectionViewCell
            cell.photoView.image =  photoGallary.images[indexPath.item]
            
            return cell
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        
        let widthCell = frameVC.width / CGFloat(countCells)
        let heightCell = widthCell
        
        return CGSize(width: widthCell, height: heightCell)
    }
}

