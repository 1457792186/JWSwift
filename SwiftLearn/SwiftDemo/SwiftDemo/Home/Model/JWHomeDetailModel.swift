//
//  JWHomeDetailModel.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeDetailModel: NSObject {
    @objc var title:String;
    @objc var imageName:String;
    @objc var type:String;
    @objc var audienceCount:Int;
    @objc var uper:String;
    
    @objc init(dataDic:NSDictionary) {
        title = dataDic.value(forKey:"title") as! String;
        imageName = dataDic.value(forKey: "imageName") as! String;
        let persons:String = dataDic.value(forKey: "audienceCount") as! String;
        audienceCount =  Int(persons)!;
        type = dataDic.value(forKey:"type") as! String;
        uper = dataDic.value(forKey: "uper") as! String;
    }
}
