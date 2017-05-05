//
//  JWTools.swift
//  SwiftDemo
//
//  Created by apple on 17/5/5.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWTools: NSObject {
    
    
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
    
    
    
}
