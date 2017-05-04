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

        self.navigationBar.tintColor = UIColor.white;
        self.navigationBar.barTintColor = UIColor.cyan;
        self.navigationBar.isTranslucent = false;
        self.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:UIColor.white];
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated);
    }
    
}
