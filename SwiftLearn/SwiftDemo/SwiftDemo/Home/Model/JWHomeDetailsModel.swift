//
//  JWHomeDetailsModel.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeDetailsModel: NSObject {
    @objc var content:NSMutableArray = NSMutableArray();
    
    @objc init(dataArr:NSArray) {
        for detailDic in dataArr {
            content.add(JWHomeDetailModel.init(dataDic: detailDic as! NSDictionary));
        }
    }
}
