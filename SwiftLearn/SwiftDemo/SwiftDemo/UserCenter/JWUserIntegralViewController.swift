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
    
    var integralData:NSMutableArray = NSMutableArray()
    var detailPage:Int = 0
    var detailData:NSMutableArray = NSMutableArray()
    var isDetail:Bool = false
    
    let integralTableHeader = "JWUserIntegralTableHeader"
    let integralTableFooter = "JWUserIntegralTableFooter"
    let integralTableCell   = "JWUserIntegralTableViewCell"
    let detailTableHeader   = "JWUserIntegralDetailTableHeader"
    let detailTableCell     = "JWUserIntegralDetailTableViewCell"
    
    let integralBtn = UIButton.init(frame: CGRect.init(x: mainScreenWidth/2.0 - 71.0, y: 7.0, width: 70.0, height: 30.0))
    let detailBtn = UIButton.init(frame: CGRect.init(x: mainScreenWidth/2.0 + 1.0, y: 7.0, width: 70.0, height: 30.0))
    let chooseSliderView = UIImageView.init(frame: CGRect.init(x: 0, y: 42.5, width: 25.0, height: 5.0))
    
    //    MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareTable()
        self.prepareUI()
        
        self.setRefreshFunction()
        self.requestIntegralData()
        self.requestIntegralDetailData(isHeader: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        integralBtn.isHidden = false
        detailBtn.isHidden = false
        chooseSliderView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        integralBtn.isHidden = true
        detailBtn.isHidden = true
        chooseSliderView.isHidden = true
    }
    
    func prepareUI() {
        
        integralBtn.setTitle("积分", for: UIControlState.normal)
        integralBtn.setTitleColor(navTitleColor, for: UIControlState.normal)
        integralBtn.setTitleColor(colorMain, for: UIControlState.selected)
        integralBtn.titleLabel?.font = JWFontAdaptor.adjustFont(fixFont: UIFont.systemFont(ofSize: 15.0))
        integralBtn.addTarget(self, action: #selector(JWUserIntegralViewController.viewTypeChangeBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar .addSubview(integralBtn)
        
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
    
    func prepareTable() {
        
        self.integralTableView.register(UINib(nibName: integralTableCell, bundle: nil), forCellReuseIdentifier: integralTableCell)
        self.integralTableView.register(UINib.init(nibName: integralTableHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: integralTableHeader)
        self.integralTableView.register(UINib.init(nibName: integralTableFooter, bundle: nil), forHeaderFooterViewReuseIdentifier: integralTableFooter)
        
        self.detailTableView.register(UINib(nibName: detailTableCell, bundle: nil), forCellReuseIdentifier: detailTableCell)
        self.detailTableView.register(UINib.init(nibName: detailTableHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: detailTableHeader)
    }
    
//    点击类型切换按钮
    @objc func viewTypeChangeBtnAction(sender: UIButton) {
        
        integralBtn.isSelected = sender.isEqual(integralBtn)
        detailBtn.isSelected = sender.isEqual(detailBtn)
        
        UIView.animate(withDuration: 0.2) {
            self.chooseSliderView.center = CGPoint.init(x: (self.integralBtn.isSelected ? self.integralBtn.center.x : self.detailBtn.center.x), y: self.chooseSliderView.center.y)
        }
        
        integralTableView.isHidden = !integralBtn.isSelected
        detailTableView.isHidden = !detailBtn.isSelected
        
    }
    
    
    //    MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView.isEqual(self.integralTableView) {
            return (integralData[section] as! NSArray).count + 1
        }else{
            return detailData.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return tableView.isEqual(self.integralTableView) ? 2 : 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.isEqual(self.integralTableView) {
            let integralCell = tableView.dequeueReusableCell(withIdentifier: integralTableCell, for: indexPath) as! JWUserIntegralTableViewCell
            if indexPath.row == 0{
                integralCell.setTopStyle()
            }else{
                let model = (integralData[indexPath.section] as! NSArray)[indexPath.row - 1]
                integralCell.setData(dataModel: model as! JWUserIntegralModel)
            }
            
            return integralCell
        }
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier: detailTableCell, for: indexPath) as! JWUserIntegralDetailTableViewCell
        let model = self.detailData[indexPath.row] as! JWUserIntegralDetailModel
        detailCell .setData(dataModel: model)
        
        return detailCell
    }
    
    //    MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return tableView.isEqual(self.integralTableView) ? (indexPath.row == 0 ? 40.0 : 44.0) : 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return tableView.isEqual(self.integralTableView) ? 50.0 : 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return tableView.isEqual(self.integralTableView) ? (section == 0 ? 12.0 : 152.0) : 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        if tableView.isEqual(self.integralTableView) {
            let integralHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: integralTableHeader) as! JWUserIntegralTableHeader
            integralHeaderView.nameLabel.text = section == 0 ? "每日奖励积分规则" : "一次性奖励积分规则"
            return integralHeaderView
        }else{
            let detailHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: detailTableHeader) as! JWUserIntegralDetailTableHeader
            return detailHeader
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        
        if tableView.isEqual(self.integralTableView) {
            if section == 0 {
                let footerView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: mainScreenWidth, height: 12.0))
                footerView.backgroundColor = JWTools.colorWithHexString(hex: "#f5f5f5")
                return footerView
            }else{
                let integralFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: integralTableFooter)
                return integralFooterView
            }
            
        }else{
            return nil
        }
    }
    
    
    //    MARK: - MJRefresh
    func setRefreshFunction() {
        self.integralTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestIntegralData()
        })
        
        self.detailTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestIntegralDetailData(isHeader:true)
        })
        
        self.detailTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.requestIntegralDetailData(isHeader:false)
        })
    }
    
    
    //    MARK: - RequestData
//    请求积分数据
    func requestIntegralData() {
        let dataArr = [
            [
                ["typeName":"今日签到","addIntegral":"10","introduce":"累计加分"],
                ["typeName":"发表帖子","addIntegral":"10","introduce":""],
                ["typeName":"回复","addIntegral":"2","introduce":""]
            ],
            [
                ["typeName":"孕期账号注册","addIntegral":"100","introduce":"累计加分"],
                ["typeName":"完善个人资料","addIntegral":"50","introduce":""],
            ]
        ]
        
        for index in 0..<dataArr.count {
            let dataSubArr = dataArr[index]
            let data = NSMutableArray()
            
            for subIndex in 0..<dataSubArr.count {
                let dataDic = dataSubArr[subIndex]
                let model = JWUserIntegralModel.initModel(dataDic: dataDic as NSDictionary)
                
                data.add(model)
            }
            integralData.add(data)
        }
        
        
        //重现加载表格数据
        self.integralTableView!.reloadData()
        //结束刷新
        self.integralTableView!.mj_header.endRefreshing()
    }
    
//    请求详情数据
    func requestIntegralDetailData(isHeader:Bool) {
        let dataArr = [
                ["typeName":"今日签到","addIntegral":"10","time":"1510296376"],
                ["typeName":"发表帖子","addIntegral":"10","time":"1508150376"],
                ["typeName":"回复","addIntegral":"2","time":"1508200376"],
                ["typeName":"今日签到","addIntegral":"10","time":"1508220376"],
                ["typeName":"发表帖子","addIntegral":"10","time":"1508400376"],
                ["typeName":"回复","addIntegral":"2","time":"1508600376"],
                ["typeName":"今日签到","addIntegral":"10","time":"1508606376"],
                ["typeName":"发表帖子","addIntegral":"10","time":"1509006376"],
                ["typeName":"回复","addIntegral":"2","time":"1509096376"],
                ["typeName":"今日签到","addIntegral":"10","time":"1509296376"],
                ["typeName":"发表帖子","addIntegral":"10","time":"1510096376"],
                ["typeName":"回复","addIntegral":"2","time":"1500296376"]
        ]
        
//        下拉刷新重置
        if isHeader {
            self.detailPage = 0
            detailData.removeAllObjects()
        }
        
        for index in 0..<dataArr.count {
            let dataDic = dataArr[index]
            let model = JWUserIntegralDetailModel.initModel(dataDic: dataDic as NSDictionary)
            
            detailData.add(model)
        }
        
        self.detailPage += 1
        
        //重现加载表格数据
        self.detailTableView!.reloadData()
        //结束刷新
        if isHeader {
            self.detailTableView!.mj_header.endRefreshing()
        }else{
            self.detailTableView!.mj_footer.endRefreshing()
        }
        
    }
}
