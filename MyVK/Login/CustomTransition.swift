//
//  CustomTransition.swift
//  10l_ArturDokhno
//
//  Created by Артур Дохно on 01.10.2021.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresented = true
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?)
    -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
            
            guard let toView = transitionContext.view(forKey: .to),
                  let fromView = transitionContext.view(forKey: .from)
            else {
                transitionContext.completeTransition(false)
                return }
            
            let containerView = transitionContext.containerView
            
            let beginState = CGAffineTransform(
                translationX: 0,
                y: containerView.frame.height)
            
            let endState = CGAffineTransform(
                translationX: 0,
                y: -containerView.frame.height)
            
            toView.transform = isPresented ? beginState : endState
            
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            
            let duration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration, animations: {
                [unowned self] in
                
                toView.transform = .identity
                fromView.transform = self.isPresented ? endState : beginState
                
            }) { (isFinished) in
                transitionContext.completeTransition(isFinished)
            }
        }
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) ->
    UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        return self
    }
    
    func animationController(
        forDismissed dismissed: UIViewController) ->
    UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        
        return self
    }
}
