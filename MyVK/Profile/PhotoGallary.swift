//
//  PhotogGallary.swift
//  10l_ArturDokhno
//
//  Created by Артур Дохно on 03.10.2021.
//

import UIKit

class PhotoGallary {
    
    var images = [UIImage]()
    
    init() {
        setupGallary()
    }
    
    func setupGallary() {
        for i in 0...6 {
            let image = UIImage(named: "image\(i)")!
            images.append(image)
        }
    }
}
