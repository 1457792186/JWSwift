//
//  LGDismissAnimationController.swift
//  LGWeChatKit
//
//  Created by jamy on 11/2/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toCtrl = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! UINavigationController).topViewController as! UICollectionViewController
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containertView = transitionContext.containerView
   
        let layoutAttrubute = toCtrl.collectionView?.layoutAttributesForItem(at: (toCtrl.selectedIndexPath)! as IndexPath)
        let selectRect = toCtrl.collectionView?.convert((layoutAttrubute?.frame)!, to: toCtrl.collectionView?.superview)
        
        toView?.alpha = 0.5
        containertView.addSubview(toView!)
        containertView.sendSubview(toBack: toView!)
        
        let snapshotView = fromView?.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = (fromView?.frame)!
        containertView.addSubview(snapshotView!)

        fromView?.removeFromSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            snapshotView?.frame = selectRect!
            toView?.alpha = 1
            }, completion: { (finish) -> Void in
                snapshotView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
    }
}
