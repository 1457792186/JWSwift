//
//  JWTools.swift
//  SwiftDemo
//
//  Created by apple on 17/5/5.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWTools: NSObject {
    
    
    //    MARK: - HUD
    /*
     *显示Hud
     *hudStr:显示的文本
     */
    @objc class func showHud(hudStr:String){
        if hudStr.isEmpty{
            return;
        }
        
        let showView:UIView = UIView();
        showView.backgroundColor = UIColor.black;
        showView.frame = CGRect.init(x: 1, y: 1, width: 1, height: 1);
        showView.alpha = 1;
        showView.layer.cornerRadius = 5;
        showView.layer.masksToBounds = true;
        UIApplication.shared.keyWindow?.addSubview(showView);
        
        
        let labelFont:UIFont = UIFont.systemFont(ofSize: 15)
        let labelFrame:CGRect = NSString.init(string:hudStr).boundingRect(with: CGSize.init(width: 290, height: 9000), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:labelFont], context: nil);
        let label:UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 5, width: ceil(labelFrame.size.width), height: ceil(labelFrame.size.height)));
        label.text = hudStr;
        label.textColor = UIColor.white;
        label.font = labelFont;
        label.textAlignment = NSTextAlignment.center;
        label.backgroundColor = UIColor.clear;
        showView.addSubview(label);
        showView.frame = CGRect.init(x: (UIScreen.main.bounds.size.width - label.frame.width)/2, y: (UIScreen.main.bounds.size.height - 100), width: (label.frame.width + 20), height: (label.frame.height + 10));
        
        UIView.animate(withDuration: 1.5, animations: { 
            showView.alpha = 0;
        }) { (true) in
            showView.removeFromSuperview();
        }
    }
    
    
    //    MARK: - Font&String
    /*
     *获取Label高度
     *label:计算的Label
     *length:限定宽高，0时为Label宽高
     *isWidth:计算宽/高，true为宽
     */
    @objc class func labelFrame(label:UILabel,length:Float,isWidth:Bool) -> CGRect {
        var lengths:Float = length;
        if length==0 {
            lengths = Float(label.frame.size.width);
        }
        var size:CGSize = CGSize.init(width: CGFloat(lengths), height: 9000);
        if !isWidth {
            lengths = Float(label.frame.size.height);
            size = CGSize.init(width: 9000, height: CGFloat(lengths));
        }
        let labelFrame:CGRect = NSString.init(string:label.text!).boundingRect(with: size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:label.font], context: nil);
        return labelFrame;
    }
    
    /*
     *文本添加行间距
     *fontSize:文本大小
     *lineSpacing:文本行间距
     *str:显示文本
     */
    @objc class func stringWithLineEndgeSet(forFontSize fontSize: CGFloat,withLineSpacing lineSpacing: CGFloat,withString str:String) -> NSAttributedString {
        //        行间距
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes = [NSAttributedStringKey.font : JWFontAdaptor.adjustFont(fixFontSize: fontSize),NSAttributedStringKey.paragraphStyle : paragraphStyle]
        let attributeString = NSAttributedString.init(string: str, attributes: attributes)
        return attributeString;
    }
    
    
    
    //    MARK: - UICOlor
    /*
     HexString转成Color
     */
    @objc class func colorWithHexString(hex:String) ->UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = String(cString[index...])
//            cString = cString.substring(from: index)
        }

        if (cString.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[..<rIndex])
//        let rString = cString.substring(to: rIndex)
        let otherString = String(cString[rIndex...])
//        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = String(otherString[..<gIndex])
//        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = String(cString[bIndex...])
//        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
    //    MARK: - UIView
    /*
     *设置边框
     */
    @objc class func viewSetBorder(borderWidth:CGFloat,borderColor:String,cornerRadius:CGFloat,withView view:UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = JWTools.colorWithHexString(hex: borderColor).cgColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
    
}
