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
    let detailBtn = UIButton.init(frame: CGRect.init(x: mainScreenWidth/2.0 + 1.0, y: 7.0, width: 70.0, height: 30.0))
    let chooseSliderView = UIImageView.init(frame: CGRect.init(x: 0, y: 42.5, width: 25.0, height: 5.0))
    
    //    MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareUI()
    }
    
    func prepareUI() {
        
        integralBtn.setTitle("积分", for: UIControlState.normal)
        integralBtn.setTitleColor(navTitleColor, for: UIControlState.normal)
        integralBtn.setTitleColor(colorMain, for: UIControlState.selected)
        integralBtn.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 15.0))
        integralBtn.addTarget(self, action: #selector(JWUserIntegralViewController.viewTypeChangeBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(integralBtn)
        
        detailBtn.setTitle("详情", for: UIControlState.normal)
        detailBtn.setTitleColor(navTitleColor, for: UIControlState.normal)
        detailBtn.setTitleColor(colorMain, for: UIControlState.selected)
        detailBtn.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 15.0))
        detailBtn.addTarget(self, action: #selector(JWUserIntegralViewController.viewTypeChangeBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(detailBtn)
        
        let lineView = UIView.init(frame: CGRect.init(x: detailBtn.frame.origin.x - 1.0, y: detailBtn.frame.origin.y, width: 0.5, height: (detailBtn.titleLabel?.font.pointSize)!))
        lineView.backgroundColor = JWTools.colorWithHexString(hex: "#f6f6f6")
        self.navigationController?.navigationBar.addSubview(lineView)
        
        chooseSliderView.image = UIImage.init(named: "chooseSlider")
        chooseSliderView.center = CGPoint.init(x: integralBtn.center.x, y: chooseSliderView.center.y)
        self.navigationController?.navigationBar.addSubview(chooseSliderView)
        
        self.viewTypeChangeBtnAction(sender: integralBtn)
        
        
    }
    
//    点击类型切换按钮
    @objc func viewTypeChangeBtnAction(sender: UIButton) {
        
        integralBtn.isSelected = sender.isEqual(integralBtn)
        detailBtn.isSelected = sender.isEqual(detailBtn)
        
        UIView.animate(withDuration: 0.2) {
            self.chooseSliderView.center = CGPoint.init(x: (self.integralBtn.isSelected ? self.integralBtn.center.x : self.detailBtn.center.x), y: self.chooseSliderView.center.y)
        }
        
        integralTableView.isHidden = integralBtn.isSelected
        detailTableView.isHidden = detailBtn.isSelected
        
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
