//
//  JWUserFansTableViewCell.swift
//  SwiftDemo
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit


class JWUserFansTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var addedFriendBtn: UIButton!
    
    var model:JWUserFansModel!
    var sendMessageBlock : funcStringBlock?
    var addFriendBlock : funcStringBlock?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dataModel:JWUserFansModel) {
        self.model = dataModel
        self.setLayout();//重新布局
        
//        self.wayLabel.text = self.model.typeName
//        self.addIntegralLabel.text = self.model.addIntegral
//        self.timeLabel.text = self.model.time
    }
    
    func setLayout(){
        
        let setCornerRadiusArr = [self.showImageView,self.sendMessageBtn,self.addedFriendBtn,self.addFriendBtn] as [UIView];
        for cornerView in setCornerRadiusArr {
            cornerView.layer.cornerRadius = cornerView.frame.size.height/2.0;
            cornerView.layer.masksToBounds = true;
        }
        
        switch (self.model.userState! as NSString).integerValue {
        case 1:
            do {
            self.addedFriendBtn.isHidden = false;
            }
        case 2:
            do {
            self.addFriendBtn.isHidden = false;
            }
        default:
            self.sendMessageBtn.isHidden = false;
        }
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        if self.sendMessageBlock != nil {
            self.sendMessageBlock!(self.model.userID!);
        }
    }
    
    @IBAction func addFriendAction(_ sender: UIButton) {
        if self.addFriendBlock != nil {
            self.addFriendBlock!(self.model.userID!);
        }
    }
    
    
}
