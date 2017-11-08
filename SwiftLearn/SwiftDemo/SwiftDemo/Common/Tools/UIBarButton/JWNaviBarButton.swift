//
//  JWNaviBarButton.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

let naviItemFont : UIFont = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 14.0))
let navTitleColor : UIColor = JWTools.colorWithHexString(hex: "#222222")

class JWNaviBarButton: UIBarButtonItem {
    
    //   设置UIBarButtonItem(简)
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString, withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector) -> JWNaviBarButton {
        
        return JWNaviBarButton.initBarItem(barImageName: imageName, withBarSelImageName: selImageName, withTitle: title, withFontColor: navTitleColor, withFontSize: naviItemFont.pointSize, withHorizontalAlignmentType: alignment, withTarget: target, withAction: action, withWidth: 30.0)
    }
    
    //    设置UIBarButtonItem，自定义长度(简)
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString, withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector , withWidth width : CGFloat) -> JWNaviBarButton {
        
        return JWNaviBarButton.initBarItem(barImageName: imageName, withBarSelImageName: selImageName, withTitle: title, withFontColor: navTitleColor, withFontSize: naviItemFont.pointSize, withHorizontalAlignmentType: alignment, withTarget: target, withAction: action, withWidth: width)
    }
    
//   设置UIBarButtonItem
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString ,withFontColor fontColor : UIColor , withFontSize fontSize: CGFloat, withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector) -> JWNaviBarButton {

        return JWNaviBarButton.initBarItem(barImageName: imageName, withBarSelImageName: selImageName, withTitle: title ,withFontColor : fontColor , withFontSize : fontSize, withHorizontalAlignmentType: alignment, withTarget: target, withAction: action, withWidth: 30.0)
    }

//    设置UIBarButtonItem，自定义长度
    class func initBarItem(barImageName imageName : NSString , withBarSelImageName selImageName : NSString , withTitle title : NSString ,withFontColor fontColor : UIColor , withFontSize fontSize: CGFloat, withHorizontalAlignmentType alignment : UIControlContentHorizontalAlignment , withTarget target : Any , withAction action : Selector , withWidth width : CGFloat) -> JWNaviBarButton {
        
        let barButton:JWButton = JWButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        barButton.contentHorizontalAlignment = alignment;
        
        if !imageName.isEqual(to: ""){
            let selImageNameNew = selImageName.isEqual(to: "") ? imageName : selImageName;
            
            barButton.setBackgroundImage(UIImage.init(named: (imageName as String)), for: UIControlState.normal)
            barButton.setBackgroundImage(UIImage.init(named: (selImageNameNew as String)), for: UIControlState.selected)
        }else if !title.isEqual(to: ""){
            barButton.setTitle((title as String), for: UIControlState.normal)
            barButton.setTitle((title as String), for: UIControlState.selected)
        }
        
        barButton.target(forAction: action, withSender: target)
        
        let barButtonItem:JWNaviBarButton = JWNaviBarButton.init(customView:barButton)
        
        return barButtonItem
    }
    
//    设置UIBarButtonItem（返回按钮）
    class func initBackBarItem(forTarget target : Any , withAction action : Selector) -> JWNaviBarButton {
        
        let barButton:JWButton = JWButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        barButton.setBackgroundImage(UIImage.init(named: "back_arrow"), for: UIControlState.normal)
        barButton.target(forAction: action, withSender: target)

        let barButtonItem:JWNaviBarButton = JWNaviBarButton.init(customView:barButton)

        return barButtonItem
    }
    
}
