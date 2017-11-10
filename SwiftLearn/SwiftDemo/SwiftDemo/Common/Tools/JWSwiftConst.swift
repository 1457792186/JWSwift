//
//  JWSwiftPCH.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

let mainScreenWidth = UIScreen.main.bounds.size.width
let mainScreenHeight = UIScreen.main.bounds.size.height

let IOS7_OR_LATER = (UIDevice.current.systemVersion as NSString).floatValue >= 7.0 ? true : false;
let IOS11_OR_LATER = (UIDevice.current.systemVersion as NSString).floatValue >= 11.0 ? true : false;

let iPhone5 = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize.init(width: 640, height: 1136), (UIScreen.main.currentMode?.size)!) : false

let isNoRetina = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize.init(width: 320, height: 480), (UIScreen.main.currentMode?.size)!) : false

let IPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) ? true : false
let IPod = (UIDevice.current.model as NSString) .isEqual(to: "iPod touch")

let colorMain = JWTools.colorWithHexString(hex: "#52c4de")


class JWSwiftConst: NSObject {
    
    @objc class func IPhone() -> Bool {
        return IPad == false && IPod == false ? true : false;
    }
    
    @objc class func IPhone4S() -> Bool {
        return JWSwiftConst.IPhone() && mainScreenHeight <= 480.0 ? true : false
    }
    
    @objc class func IPhone5S() -> Bool {
        return JWSwiftConst.IPhone() && mainScreenHeight > 480.0 && mainScreenHeight <= 568.0 ? true : false
    }
    
    @objc class func IPhone6() -> Bool {
        return JWSwiftConst.IPhone() && mainScreenHeight > 568.0 && mainScreenHeight <= 667.0 ? true : false;
    }
    
    @objc class func IPhone6p() -> Bool {
        return JWSwiftConst.IPhone() && mainScreenHeight > 736.0 && mainScreenHeight <= 800.0 ? true : false;
    }
    
    @objc class func IPhoneX() -> Bool {
        return IPad == false && mainScreenHeight >= 812.0 ? true : false;
    }
    
    @objc class func NaviBarHeight() -> CGFloat {
        return JWSwiftConst.IPhoneX() ? 64.0 : 88.0;
    }
    
    @objc class func TabBarHeight() -> CGFloat {
        return JWSwiftConst.IPhoneX() ? 50.0 : 84.0;
    }
    
}
