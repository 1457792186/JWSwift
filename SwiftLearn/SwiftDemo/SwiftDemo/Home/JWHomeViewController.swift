//
//  JWHomeViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeViewController: JWBasicViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var homeTableView: UITableView!
    var dataArr = [JWHomeModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页";
        
        self.registerTableView();
        self.dataArrSet();
    }

    func registerTableView() -> Void {
//        self.homeTableView.register(JWHomeTableViewCell.self, forCellReuseIdentifier: "JWHomeTableViewCell");
        
        let cellNib = UINib(nibName: "JWHomeTableViewCell", bundle: nil)
        self.homeTableView.register(cellNib, forCellReuseIdentifier: "JWHomeTableViewCell")
    }
    
    func dataArrSet(){
        let nameArr = ["英雄联盟","DOTA"];
        let subNameArr = ["各路英雄大逃杀","荣耀背后的嗜血神灵"];
        
        let titleArr = ["英雄联盟","英雄联盟","英雄联盟","英雄联盟"];
        let anchorArr = ["水晶卡特","赛事专用直播间","Riot、LCS","主播油条"];
        let countArr = ["4535","70000","69000","476000"];
        let subTitleArr = ["2J杀人如何利用卡特琳娜顺利爬..","LSPL春季赛SNG vs RYL直播中","LCS TSM vs FOX 正在直播","油条：五个隐身英雄套路上分系.."];
        let imgArr = ["home_logo_video0","home_logo_video1","home_logo_video2","home_logo_video3"];
        
        for index in 0..<2{
            let dataDic:NSMutableDictionary = NSMutableDictionary.init(capacity: 0);
            dataDic.setObject(nameArr[index%2], forKey: "title" as NSCopying);
            dataDic.setObject("home_logo_type\(index%2)", forKey:"imageName" as NSCopying);
            dataDic.setObject(subNameArr[index%2], forKey:"subTitle" as NSCopying);
            let contentArr:NSMutableArray = NSMutableArray.init(capacity: 0);
            for idx in 0..<titleArr.count {
                if idx%2 == index {
                    let contentDic:NSMutableDictionary = NSMutableDictionary.init(capacity: 0);
                    contentDic.setObject(titleArr[idx], forKey: "type" as NSCopying);
                    contentDic.setObject(imgArr[idx], forKey: "imageName" as NSCopying);
                    contentDic.setObject(countArr[idx], forKey: "audienceCount" as NSCopying);
                    contentDic.setObject(subTitleArr[idx], forKey: "title" as NSCopying);
                    contentDic.setObject(anchorArr[idx], forKey: "uper" as NSCopying);
                    contentArr.add(contentDic);
                }
            }
            dataDic.setObject(contentArr, forKey:"content" as NSCopying);
            dataArr.append(JWHomeModel.init(dataDic: dataDic));
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let detailVC = JWHomeDetailViewController();
        let detailModel = dataArr[indexPath.row];
        detailVC.dataModel = detailModel.content;
        self.navigationController?.pushViewController(detailVC, animated:true);
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return (80*UIScreen.main.bounds.size.width/375.0);
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataArr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let homeCell:JWHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "JWHomeTableViewCell", for: indexPath) as! JWHomeTableViewCell;
        homeCell.setData(dataModel: dataArr[indexPath.row]);
        return homeCell;
    }
    
}
