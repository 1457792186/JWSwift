//
//  JWTools.swift
//  SwiftDemo
//
//  Created by apple on 17/5/5.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width

class JWTools: NSObject {
    
    /*
     *显示Hud
     *hudStr:显示的文本
     */
    class func showHud(hudStr:String){
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
        let labelFrame:CGRect = NSString.init(string:hudStr).boundingRect(with: CGSize.init(width: 290, height: 9000), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:labelFont], context: nil);
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
    
    /*
     *获取Label高度
     *label:计算的Label
     *length:限定宽高，0时为Label宽高
     *isWidth:计算宽/高，true为宽
     */
    class func labelFrame(label:UILabel,length:Float,isWidth:Bool) -> CGRect {
        var lengths:Float = length;
        if length==0 {
            lengths = Float(label.frame.size.width);
        }
        var size:CGSize = CGSize.init(width: CGFloat(lengths), height: 9000);
        if !isWidth {
            lengths = Float(label.frame.size.height);
            size = CGSize.init(width: 9000, height: CGFloat(lengths));
        }
        let labelFrame:CGRect = NSString.init(string:label.text!).boundingRect(with: size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:label.font], context: nil);
        return labelFrame;
    }
    
}
