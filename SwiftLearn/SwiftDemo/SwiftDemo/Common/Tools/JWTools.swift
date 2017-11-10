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
    
    /*
     *线条图片
     */
    @objc class func imageWithColor(color:UIColor) -> UIImage{
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //    MARK: - JSON
    /*
     *JSONString转换为字典
     */
    @objc class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    /**
     字典转换为JSONString
     */
    @objc class func getJSONStringFromDictionary(dictionary:NSDictionary) -> NSString {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString!
    }
    
    //    MARK: - Date
    /*
     *传一个日期字符串，判断是否是昨天，或者是今天的日期
     */
    @objc class func dateStr(dayCheck dateStr:String) ->String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date.init(timeIntervalSince1970: (dateStr as NSString).doubleValue)
        
        let calendar = NSCalendar.current
        
        
        if calendar.isDateInYesterday(date) {
            dateFormatter.dateFormat = "HH:mm:ss"
            return NSString.init(format: "昨天 %@", dateFormatter.string(from: date)) as String
        }else if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm:ss"
            return NSString.init(format: "今天 %@", dateFormatter.string(from: date)) as String
        }else{
            dateFormatter.dateFormat = "MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        
    }
    
    /*
     *传一个日期字符串，判断是否是昨天，或者是多少小时、分钟前
     */
    @objc class func dateWithStr(timeCheck dateStr:String) ->String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date.init(timeIntervalSince1970: (dateStr as NSString).doubleValue)
        
        let calendar = NSCalendar.current
        
        
        if calendar.isDateInYesterday(date) {
            dateFormatter.dateFormat = "HH:mm:ss"
            return NSString.init(format: "昨天 %@", dateFormatter.string(from: date)) as String
        }else if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH";
            var time = (dateFormatter.string(from: date) as NSString).integerValue
            var timeCurrent = (dateFormatter.string(from: Date.init(timeIntervalSince1970: 0)) as NSString).integerValue
            if timeCurrent - time == 1{
                dateFormatter.dateFormat = "mm";
                time = (dateFormatter.string(from: date) as NSString).integerValue
                timeCurrent = (dateFormatter.string(from: Date.init(timeIntervalSince1970: 0)) as NSString).integerValue
                
                if timeCurrent - time >= 0{
                    return "1小时前"
                }
                
                return NSString.init(format: "%zi分钟前", timeCurrent - time + 60) as String
            }else if timeCurrent - time == 0{
                dateFormatter.dateFormat = "mm";
                time = (dateFormatter.string(from: date) as NSString).integerValue
                timeCurrent = (dateFormatter.string(from: Date.init(timeIntervalSince1970: 0)) as NSString).integerValue
                
                return NSString.init(format: "%zi分钟前", timeCurrent - time) as String
            }
            
            return NSString.init(format: "%zi小时前", dateFormatter.string(from: date)) as String
        }else{
            dateFormatter.dateFormat = "MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        
    }
    
    /*
     *传一个日期字符串，返回年月日
     */
    @objc class func dateStr(commonDate dateStr:String) ->String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date.init(timeIntervalSince1970: (dateStr as NSString).doubleValue)
        
        
        return dateFormatter.string(from: date)
        
    }
    
    
    
}
