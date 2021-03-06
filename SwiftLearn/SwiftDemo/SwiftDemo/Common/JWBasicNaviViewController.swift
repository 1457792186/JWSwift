//
//  JWBasicNaviViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWBasicNaviViewController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //此处修改底部线条颜色
        self.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationBar.shadowImage = JWTools.imageWithColor(color: JWTools.colorWithHexString(hex: "#ececec"))
        
        self.navigationBar.tintColor = UIColor.white;
        self.navigationBar.barTintColor = UIColor.white;
        self.navigationBar.isTranslucent = false;
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 20),NSAttributedStringKey.foregroundColor:UIColor.black];
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true;
            
            viewController.navigationItem.leftBarButtonItem = JWNaviBarButton.initBackBarItem(forTarget: self, withAction: #selector(JWBasicNaviViewController.backBarButtonClick))
            
        }
        super.pushViewController(viewController, animated: animated);
    }
    
    @objc func backBarButtonClick() {
        self.popViewController(animated: true)
    }
    
}
