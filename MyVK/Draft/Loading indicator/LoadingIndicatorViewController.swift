//
//  LoadingIndicatorViewController.swift
//  9l_ArturDokhno
//
//  Created by Артур Дохно on 19.09.2021.
//

import UIKit

class LoadingIndicatorViewController: UIViewController {
    
    let spinningCircleView = SpinningCircleView()
    let rotatingCirclesView = RotationgCirclesView()
    let fadingCircleView = FadingCircleVeiew()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureSpinningCircleView()
        configureRotatingCircles()
        configureFadingCircleView()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
    }
    
    private func configureSpinningCircleView() {
        spinningCircleView.frame = CGRect(
            x: 125,
            y: 100,
            width: 100,
            height: 100)
        
        view.addSubview(spinningCircleView)
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewTapped)))
    }
    
    private func configureRotatingCircles() {
        view.addSubview(rotatingCirclesView)
        
        NSLayoutConstraint.activate([
            rotatingCirclesView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            rotatingCirclesView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            rotatingCirclesView.heightAnchor.constraint(
                equalToConstant: 100),
            rotatingCirclesView.widthAnchor.constraint(
                equalToConstant: 200)
        ])
    }
    
    private func configureFadingCircleView() {
        view.addSubview(fadingCircleView)
        
        NSLayoutConstraint.activate([
            fadingCircleView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            fadingCircleView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor, constant: 150),
            fadingCircleView.heightAnchor.constraint(
                equalToConstant: 40),
            fadingCircleView.widthAnchor.constraint(
                equalToConstant: 150)
        ])
    }
    
    @objc func viewTapped() {
        
        spinningCircleView.animate()
        
        rotatingCirclesView.animate(rotatingCirclesView.circle1, counter: 1)
        rotatingCirclesView.animate(rotatingCirclesView.circle2, counter: 3)
        
        fadingCircleView.animate()
    }
    
}
