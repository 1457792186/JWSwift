//
//  JWUserIntegralTableFooter.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralTableFooter: UITableViewHeaderFooterView {

    @IBOutlet weak var detailIntroduceLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.prepareUI()
        
    }

    func prepareUI() {
        self.detailIntroduceLabel.attributedText = JWTools.stringWithLineEndgeSet(forFontSize: self.detailIntroduceLabel.font.pointSize,withLineSpacing : 14.0,withString :"1.可以在社区提问给予专家积分\n2.可以在兑换专区兑换礼品")
        
        JWTools.viewSetBorder(borderWidth: 1.0, borderColor: "#ececec", cornerRadius: 15.0, withView: borderView)
        
    }
    
}
