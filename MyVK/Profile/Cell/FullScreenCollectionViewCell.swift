//
//  FullScreenCollectionViewCell.swift
//  10l_ArturDokhno
//
//  Created by Артур Дохно on 03.10.2021.
//

import UIKit

class FullScreenCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 3.5
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoView
    }
    
    func scrollViewDidEndZooming(
        _ scrollView: UIScrollView,
        with view: UIView?,
        atScale scale: CGFloat) {
            scrollView.zoomScale = 1
        }
    
}
