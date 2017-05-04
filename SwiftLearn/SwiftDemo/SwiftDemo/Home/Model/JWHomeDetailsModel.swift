//
//  JWHomeDetailsModel.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeDetailsModel: NSObject {
    var content:NSMutableArray = NSMutableArray();
    
    init(dataArr:NSArray) {
        for detailDic in dataArr {
            content.add(JWHomeDetailModel.init(dataDic: detailDic as! NSDictionary));
        }
    }
}
