//
//  JWMeViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWMeViewController: JWBasicViewController {

    @IBOutlet weak var avatarBtn: UIButton!
    @IBOutlet weak var pointBtn: JWButton!
/*button    tag:
     101-每日签到
     102-我的话题
     103-我的活动
     104-积分商城
     201~208-关注与粉丝~手机认证
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
        
        self.pointBtn.layer.cornerRadius = self.pointBtn.frame.size.height / 2.0;
        self.pointBtn.layer.borderWidth = 1.0;
        self.pointBtn.layer.borderColor = JWTools.colorWithHexString(hex: "#f5f5f5").cgColor
        self.pointBtn.layer.masksToBounds = true;
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
