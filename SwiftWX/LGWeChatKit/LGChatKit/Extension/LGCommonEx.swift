//
//  LGCommonEx.swift
//  LGChatViewController
//
//  Created by jamy on 10/8/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    func resizeImage() -> UIImage {
       return self.stretchableImage(withLeftCapWidth: Int(self.size.width / CGFloat(2)), topCapHeight: Int(self.size.height / CGFloat(2)))
    }
}

extension UIButton {
    func addAnimation(_ durationTime: Double) {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.isRemovedOnCompletion = true
        
        let animationZoomOut = CABasicAnimation(keyPath: "transform.scale")
        animationZoomOut.fromValue = 0
        animationZoomOut.toValue = 1.2
        animationZoomOut.duration = 3/4 * durationTime
        
        let animationZoomIn = CABasicAnimation(keyPath: "transform.scale")
        animationZoomIn.fromValue = 1.2
        animationZoomIn.toValue = 1.0
        animationZoomIn.beginTime = 3/4 * durationTime
        animationZoomIn.duration = 1/4 * durationTime
        
        groupAnimation.animations = [animationZoomOut, animationZoomIn]
        self.layer.add(groupAnimation, forKey: "addAnimation")
    }
}


extension NSString {
    func stringWidthFont(_ font: UIFont) -> CGFloat {
        if self.length < 1 {
            return 0.0
        }
        
        let size = self.boundingRect(with: CGSize(width: 200, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return size.width ?? 0.0
    }
}


extension UIButton {
    class func createButton(_ title: String, backGroundColor: UIColor) -> UIButton {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState())
        button.backgroundColor = backGroundColor
        button.setBackgroundImage(UIImage.imageWithColor(backGroundColor), for: UIControlState())
        return button
    }
}




