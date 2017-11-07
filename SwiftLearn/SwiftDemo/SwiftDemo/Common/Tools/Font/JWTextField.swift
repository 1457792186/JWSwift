//
//  JWTextField.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        super.font = JWFontAdaptor.adjustFont(fixFont: self.font!);
    }

}
