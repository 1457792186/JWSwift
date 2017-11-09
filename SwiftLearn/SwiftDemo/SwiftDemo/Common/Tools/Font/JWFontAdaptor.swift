//
//  JWFontAdaptor.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

let IPHONE5_INCREMENT : CGFloat = 0.0

let IPHONE6_INCREMENT : CGFloat = 0.0

let IPHONE6PLUS_INCREMENT : CGFloat = 0.0


class JWFontAdaptor: NSObject {
    @objc class func adjustFont(fixFont font : UIFont) -> UIFont {
        var newFont = UIFont()
        if iPhone5 {
            newFont = UIFont.init(name: font.fontName, size: (font.pointSize + IPHONE5_INCREMENT))!
        }else if (JWSwiftConst.IPhone6()){
            newFont = UIFont.init(name: font.fontName, size: (font.pointSize + IPHONE6_INCREMENT))!
        }else if (JWSwiftConst.IPhone6p()){
            newFont = UIFont.init(name: font.fontName, size: (font.pointSize + IPHONE6PLUS_INCREMENT))!
        }else{
            newFont = font;
        }
        
        return newFont;
    }
    
    @objc class func adjustFont(fixFontSize fontSize : CGFloat) -> UIFont {
        
        return JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: fontSize));
    }
}
