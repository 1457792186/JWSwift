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
    
    var detailPage = 0
    var detailData:NSMutableArray = NSMutableArray()
    var isDetail:Bool = false
    
    let integralBtn = UIButton.init(frame: CGRect.init(x: mainScreenWidth/2.0 - 71.0, y: 7.0, width: 70.0, height: 30.0))
    let detailBtn = UIButton.init(frame: CGRect.init(x: mainScreenWidth/2.0, y: 7.0, width: 70.0, height: 30.0))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func prepareUI() {
        
        integralBtn.setTitle("积分", for: UIControlState.normal)
        integralBtn.setTitleColor(navTitleColor, for: UIControlState.normal)
        integralBtn.setTitleColor(navTitleColor, for: UIControlState.selected)
        integralBtn.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 15.0))
        integralBtn.isSelected = true
        integralBtn.addTarget(self, action: #selector(JWUserIntegralViewController.viewTypeChangeBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(integralBtn)
        
        detailBtn.setTitle("详情", for: UIControlState.normal)
        detailBtn.setTitleColor(navTitleColor, for: UIControlState.normal)
        detailBtn.setTitleColor(navTitleColor, for: UIControlState.selected)
        detailBtn.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 15.0))
        detailBtn.isSelected = false
        detailBtn.addTarget(self, action: #selector(JWUserIntegralViewController.viewTypeChangeBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(detailBtn)
        
    }
    
    
    @objc func viewTypeChangeBtnAction(sender: UIButton) {
        
        
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
