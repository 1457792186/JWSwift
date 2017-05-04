//
//  LGPresentAnimationController.swift
//  LGWeChatKit
//
//  Created by jamy on 11/2/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGPresentAnimationController: NSObject , UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromCtrl = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UINavigationController).topViewController as! UICollectionViewController
        let toCtrl = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containertView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toCtrl!)
        let layoutAttribute = fromCtrl.collectionView?.layoutAttributesForItem(at: (fromCtrl.selectedIndexPath)! as IndexPath)
        let selectRect = fromCtrl.collectionView?.convert((layoutAttribute?.frame)!, to: fromCtrl.collectionView?.superview)

        toView?.frame = selectRect!
        containertView.addSubview(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: { () -> Void in
            fromView?.alpha = 0.5
            toView?.frame = finalFrame
            }) { (finish) -> Void in
               transitionContext.completeTransition(true)
                fromView?.alpha = 1
        }
    }
}
