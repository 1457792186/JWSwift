//
//  JWNaviBarButton.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

let naviItemFont : UIFont = UIFont.systemFont(ofSize: 14.0)


class JWNaviBarButton: UIBarButtonItem {
    
//   设置UIBarButtonItem
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString , withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector) -> JWNaviBarButton {
        
        return JWNaviBarButton.initBarItem(barImageName: imageName, withBarSelImageName: selImageName, withTitle: title, withHorizontalAlignmentType: alignment, withTarget: target, withAction: action, withWidth: 30.0)
    }
    
//    设置UIBarButtonItem，自定义长度
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString , withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector , withWidth width : CGFloat) -> JWNaviBarButton {
        
        if imageName.isEqual(to: "") && selImageName.isEqual(to: "") && title.isEqual(to: "") {
            return JWNaviBarButton.init();
        }else if title.isEqual(to: ""){
            
        }else{
            
        }
        
        
    }
    
////    设置UIBarButtonItem（返回按钮）
//    class func initBackBarItem() -> JWNaviBarButton {
//        var barButton:JWButton = JWButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
//        barButton.
//
//        let barButtonItem:JWNaviBarButton = JWNaviBarButton.init(customView:barButton)
//
//        return barButtonItem
//    }
//
////    设置UIBarButtonItem（只有图片）
//    class func initImageBarItem() -> JWNaviBarButton {
//
//
//
//    }
//
////    设置UIBarButtonItem（只有文字）
//    class func initImageBarItem() -> JWNaviBarButton {
//
//
//
//    }
    
}
