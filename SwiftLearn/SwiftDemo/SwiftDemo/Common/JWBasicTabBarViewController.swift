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

    func initWithChildControllers(){
        let matchVC = JWMatchViewController();
        let entertainmentVC = JWEntertainmentViewController();
        let homeVC = JWHomeViewController();
        let mallVC = JWMallViewController();
        let meVC = JWMeViewController();
        
        let vcArr:NSArray = [matchVC,entertainmentVC,homeVC,mallVC,meVC];
        
        let nameArr:NSArray = ["赛事", "娱乐", "首页", "商城", "我的"];
        let imageArr:NSArray = ["tabbar_match", "tabbar_entertainment", "tabbar_homepage", "tabbar_mall", "tabbar_me"];
        let imageSelArr:NSArray = ["tabbar_match_sel", "tabbar_entertainment_sel", "tabbar_homepage_sel", "tabbar_mall_sel", "tabbar_me_sel"];
        
        for idx in 0..<nameArr.count{
            self.addChildVC(vc: vcArr[idx] as! UIViewController, title: nameArr[idx] as! String as String, imageName: imageArr[idx] as! String, imageSelName: imageSelArr[idx] as! String)
        }
    }
    
    func addChildVC(vc:UIViewController,title:String,imageName:String,imageSelName:String){
        vc.tabBarItem.title = title;
        vc.title = title;
        vc.tabBarItem.image = UIImage.init(named: imageName);
        vc.tabBarItem.selectedImage = UIImage.init(named: imageSelName);
        
        let naviVC = JWBasicNaviViewController.init(rootViewController: vc);//此处需在自定义类中重写父类方法
        self.addChildViewController(naviVC);
    }

}
