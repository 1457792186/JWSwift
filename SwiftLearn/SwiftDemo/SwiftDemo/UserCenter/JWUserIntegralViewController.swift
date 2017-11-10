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

        self.prepareUI()
        self.prepareTable()
        
        self.setRefreshFunction()
        self.requestIntegralData()
        self.requestIntegralDetailData(isHeader: true)
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
        
        integralTableView.isHidden = integralBtn.isSelected
        detailTableView.isHidden = detailBtn.isSelected
        
    }
    
    
    //    MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView.isEqual(self.integralTableView) {
            return (integralData[section] as! NSArray).count
        }else{
            return detailData.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return tableView.isEqual(self.integralTableView) ? 1 : 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init();
    }
    
    //    MARK: - UITableViewDelegate
    
    
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
            ]]
        
        for index in 0..<dataArr.count {
            let dataSubArr = dataArr[index]
            let data = NSMutableArray()
            
            for subIndex in 0..<dataSubArr.count {
                let dataDic:[String:String] = dataSubArr[subIndex]
                let dataJSON = JWTools.getJSONStringFromDictionary(dictionary: dataDic as NSDictionary)
                let model:[JWUserIntegralModel] = Mapper<JWUserIntegralModel>().mapArray(JSONString: dataJSON)!
//                let model = Mapper<JWUserIntegralModel>().map(JSONString: dataJSON)
                data.add(model)
            }
            integralData.add(data)
        }
        
        
        //重现加载表格数据
        self.integralTableView!.reloadData()
        //结束刷新
        self.integralTableView!.mj_header.endRefreshing()
    }
    
    func requestIntegralDetailData(isHeader:Bool) {
        
        
        
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
