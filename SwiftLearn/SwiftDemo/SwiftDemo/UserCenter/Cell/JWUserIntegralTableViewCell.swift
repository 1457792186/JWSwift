//
//  JWUserIntegralTableViewCell.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addIntegralLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    
    @IBOutlet weak var bottomLineView: UIView!
    
    var model:JWUserIntegralModel = JWUserIntegralModel.init()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    首栏样式
    func setTopStyle() {
        self.nameLabel.font = JWFontAdaptor.adjustFont(fixFontSize: 14.0)
        self.addIntegralLabel.font = JWFontAdaptor.adjustFont(fixFontSize: 14.0)
        self.introduceLabel.font = JWFontAdaptor.adjustFont(fixFontSize: 14.0)
        
        self.contentView.backgroundColor = JWTools.colorWithHexString(hex: "#f7edeb")
        self.bottomLineView.isHidden = true
    }
    
    func setData(dataModel:JWUserIntegralModel) {
        self.model = dataModel
        self.nameLabel.text = self.model.typeName
        self.addIntegralLabel.text = self.model.addIntegral
        self.introduceLabel.text = self.model.introduce
    }
    
}
