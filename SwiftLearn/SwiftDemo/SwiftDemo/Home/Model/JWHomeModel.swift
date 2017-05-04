//
//  JWHomeModel.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeModel: NSObject {
    var title:String;
    var imageName:String;
    var subTitle:String;
    var content:JWHomeDetailsModel;
    
    init(dataDic:NSDictionary){
        title = dataDic.value(forKey:"title") as! String;
        imageName = dataDic.value(forKey: "imageName") as! String;
        subTitle = dataDic.value(forKey: "subTitle") as! String;
        let dataArr:NSArray = dataDic.value(forKey: "content") as! NSArray;
        content = JWHomeDetailsModel(dataArr:dataArr);
    }
}
