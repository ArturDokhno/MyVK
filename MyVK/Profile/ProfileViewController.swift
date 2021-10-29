//
//  ProfileViewController.swift
//  4l_ArturDokhno
//
//  Created by Артур Дохно on 09.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var city: UILabel!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var colletctionVIew: UICollectionView!
    
    let identifire = "ImageCollectionViewCell"
    let photoGallary = PhotoGallary()
    let countCells = 3
    let offset:CGFloat = 2.0
    
    private let shadowView = ShadowView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = Singleton.shared
        session.nameUser = "Artur Dokhno"
        session.ageUser = "29 august 1992"
        session.cityUser = "Surgut"
        
        name.text = session.nameUser
        age.text = String(describing: session.ageUser)
        city.text = session.cityUser
        
        colletctionVIew.delegate = self
        colletctionVIew.dataSource = self
        colletctionVIew.register(
            UINib(
                nibName: "ImageCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: identifire)
        
        setup()
    }
    
    private func setup() {
        let image = UIImage(named: "Artur")
        
        containerView.addSubview(shadowView)
        shadowView.image = image
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        shadowView.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor).isActive = true
        shadowView.topAnchor.constraint(
            equalTo: containerView.topAnchor).isActive = true
        shadowView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor).isActive = true
    }
    
}


extension ProfileViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    
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
                for: indexPath) as! ImageCollectionViewCell
            
            cell.photoView.image = photoGallary.images[indexPath.item]
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(
                withIdentifier: "FullScreenViewController")
            as! FullScreenViewController
            
            vc.photoGallary = photoGallary
            vc.indexPath = indexPath
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
}
