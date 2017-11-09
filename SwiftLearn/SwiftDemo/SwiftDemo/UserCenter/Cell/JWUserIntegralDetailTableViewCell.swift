//
//  JWUserIntegralDetailTableViewCell.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var wayLabel: UILabel!
    @IBOutlet weak var addIntegralLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model:JWUserIntegralDetailModel = JWUserIntegralDetailModel.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dataModel:JWUserIntegralDetailModel) {
        self.model = dataModel
        self.wayLabel.text = self.model.typeName
        self.addIntegralLabel.text = self.model.addIntegral
        self.timeLabel.text = self.model.time
    }
    
}
