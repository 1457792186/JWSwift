//
//  JWTabBarVC.swift
//  JWSwif
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.init(white: 0.3, alpha: 1)
        self.tabBar.tintColor = UIColor.red
        
        self.addChildViewControllers()
        
    }

    func addChildViewControllers() {
        
    }
    
    func naviBackStyleSet() {
        let inserts = UIEdgeInsetsMake(4, 0, -4, 0)
        let alignedImage = UIImage.init(named: "navbar_white_arrow")
//        alignedImage.im
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
