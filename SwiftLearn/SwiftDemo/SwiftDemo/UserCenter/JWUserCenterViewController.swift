//
//  JWMeViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserCenterViewController: JWBasicViewController {
    
    @IBOutlet weak var avatarBtn: UIButton!
    @IBOutlet weak var integralBtn: JWButton!
    
/*button    tag:
     101-每日签到
     102-我的话题
     103-我的活动
     104-积分商城
     201~208-关注与粉丝~手机认证
     @IBAction func userInfoEditButtonClickAction(_ sender: Any) {
     }
     */
    
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var baseViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "个人中心";
        
        self.prepareUI();
        
    }

    @objc func prepareUI() {
//        基视图高度适配
        let mainViewHeight = mainScreenHeight - JWSwiftConst.NaviBarHeight() - JWSwiftConst.TabBarHeight()
        var baseViewHeight : CGFloat = mainViewHeight;
        
        if mainViewHeight <= 600 {
            baseViewHeight = 600.0;
        }
        
        self.baseScrollView.contentSize = CGSize.init(width: mainScreenWidth, height: baseViewHeight)
        self.baseViewHeight.constant = baseViewHeight;
        self.view.updateConstraints();
        
//        控件设置
        self.avatarBtn.layer.cornerRadius = self.avatarBtn.frame.size.width / 2.0;
        self.avatarBtn.layer.masksToBounds = true;
        
        self.integralBtn.layer.cornerRadius = self.integralBtn.frame.size.height / 2.0;
        self.integralBtn.layer.borderWidth = 1.0;
        self.integralBtn.layer.borderColor = JWTools.colorWithHexString(hex: "#f5f5f5").cgColor
        self.integralBtn.layer.masksToBounds = true;
        
        for index in 101..<104 {
            let btn = self.view.viewWithTag(index)
            (btn as! UIButton).addTarget(self, action: #selector(JWUserCenterViewController.buttonClickAction(_:)), for: UIControlEvents.touchUpInside)
        }
        for index in 201..<208 {
            let btn = self.view.viewWithTag(index)
            (btn as! UIButton).addTarget(self, action: #selector(JWUserCenterViewController.buttonClickAction(_:)), for: UIControlEvents.touchUpInside)
        }
        
    }
    
    // MARK: - ButtonAction
    @objc func buttonClickAction(_ sender: UIButton) {
        var pushVC = UIViewController()
        
        let targetID = sender.tag
        switch targetID {
        case 101:
            pushVC = JWSignInViewController()
        case 102:
            pushVC = JWUserTopicViewController()
        case 103:
            pushVC = JWuserActivityViewController()
        case 104:
            pushVC = JWIntegralShopViewController()
        case 201:
            pushVC = JWUserFansViewController()
        case 202:
            pushVC = JWUserDynamicViewController()
        case 203:
            pushVC = JWUserCollectionViewController()
        case 204:
            pushVC = JWUserOrderViewController()
        case 205:
            pushVC = JWSysNotificationViewController()
        case 206:
            pushVC = JWUserMessageViewController()
        case 207:
            pushVC = JWUserSettingViewController()
        case 208:
            pushVC = JWUserPhoneCheckViewController()
        default:
            pushVC = UIViewController()
        }
        
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    
    @IBAction func userInfoEditBtnAction(_ sender: Any) {
        let userEditVC = JWUserEditViewController()
        self.navigationController?.pushViewController(userEditVC, animated: true)
    }
    
    @IBAction func userIntegralBtnAction(_ sender: Any) {
        let userIntegralVC = JWUserIntegralViewController()
        self.navigationController?.pushViewController(userIntegralVC, animated: true)
    }
    
}
