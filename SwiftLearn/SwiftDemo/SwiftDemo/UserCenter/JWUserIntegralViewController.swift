//
//  JWUserIntegralViewController.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var integralTableView: UITableView!
    @IBOutlet weak var detailTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的积分"
    }
    
    
    //    MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init();
    }
    
    //    MARK: - UITableViewDelegate
    
}
