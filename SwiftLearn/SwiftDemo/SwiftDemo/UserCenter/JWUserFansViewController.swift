//
//  JWUserFansViewController.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserFansViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var fansTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关注与粉丝"
    }

    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init();
    }
    
    // MARK: - UITableViewDataSource
    
    
    
}
