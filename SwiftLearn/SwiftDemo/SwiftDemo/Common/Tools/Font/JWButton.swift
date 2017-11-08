//
//  JWButton.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fitFontSize()
    }

    func fitFontSize() {
        self.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: (self.titleLabel?.font)!)
    }
    
    
}
