//
//  JWUserIntegralViewController.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralViewController: UIViewController {

    @IBOutlet weak var integralTableView: UITableView!
    @IBOutlet weak var detailTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的积分"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
