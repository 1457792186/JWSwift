//
//  JWHomeTableViewCell.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeTableViewCell: UITableViewCell {
    var model:JWHomeModel? = nil;
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dataModel:JWHomeModel){
        model = dataModel;
        self.showImageView?.image = UIImage.init(named: (model?.imageName)!);
        self.nameLabel?.text = model?.title as String?;
        self.introLabel?.text = model?.subTitle;
    }
}
