//
//  LGColorEx.swift
//  LGChatViewController
//
//  Created by gujianming on 15/10/8.
//  Copyright © 2015年 jamy. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    
    convenience init?(hexString: String, alpha: Float) {
        var hex = hexString
        
        if hex.hasPrefix("#") {
            hex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1))
        }
   
        if let _ = hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) {
            if hex.lengthOfBytes(using: String.Encoding.utf8) == 3 {
                let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 1))
                let greenHex = hex.substring(with: (hex.characters.index(hex.startIndex, offsetBy: 1) ..< hex.characters.index(hex.startIndex, offsetBy: 2)))
                let blueHex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 2))
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 2))
            let greenHex = hex.substring(with: (hex.characters.index(hex.startIndex, offsetBy: 2) ..< hex.characters.index(hex.startIndex, offsetBy: 4)))
            let blueHex = hex.substring(with: (hex.characters.index(hex.startIndex, offsetBy: 4) ..< hex.characters.index(hex.startIndex, offsetBy: 6)))
            
            var redInt:   CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt:  CUnsignedInt = 0
            
            Scanner(string: redHex).scanHexInt32(&redInt)
            Scanner(string: greenHex).scanHexInt32(&greenInt)
            Scanner(string: blueHex).scanHexInt32(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else
        {
            self.init()
            return nil
        }
    }
    
    convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    
    convenience init?(hex: Int, alpha: Float) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String, alpha: alpha)
    }
}
