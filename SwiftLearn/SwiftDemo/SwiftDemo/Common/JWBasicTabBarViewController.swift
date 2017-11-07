//
//  JWBasicTabBarViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWBasicTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initWithChildControllers();
    }

    @objc func initWithChildControllers(){
        let homeVC = JWHomeViewController();
        let topicVC = JWTopicViewController();
        let entertainmentVC = JWEntertainmentViewController();
        let toolVC = JWToolViewController();
        let meVC = JWMeViewController();
        
        let vcArr:NSArray = [topicVC,entertainmentVC,homeVC,toolVC,meVC];
        
        let nameArr:NSArray = ["社区", "娱乐", "首页", "工具", "我的"];
        let imageArr:NSArray = ["tabbar_match", "tabbar_entertainment", "tabbar_homepage", "tabbar_mall", "tabbar_me"];
        let imageSelArr:NSArray = ["tabbar_match_sel", "tabbar_entertainment_sel", "tabbar_homepage_sel", "tabbar_mall_sel", "tabbar_me_sel"];
        
        for idx in 0..<nameArr.count{
            self.addChildVC(vc: vcArr[idx] as! UIViewController, title: nameArr[idx] as! String as String, imageName: imageArr[idx] as! String, imageSelName: imageSelArr[idx] as! String)
        }
    }
    
    @objc func addChildVC(vc:UIViewController,title:String,imageName:String,imageSelName:String){
        vc.tabBarItem.title = title;
        vc.title = title;
        vc.tabBarItem.image = UIImage.init(named: imageName);
        vc.tabBarItem.selectedImage = UIImage.init(named: imageSelName);
        
        let naviVC = JWBasicNaviViewController.init(rootViewController: vc);//此处需在自定义类中重写父类方法
        self.addChildViewController(naviVC);
    }

}
