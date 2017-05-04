//
//  JWHomeDetailModel.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeDetailModel: NSObject {
    var title:String;
    var imageName:String;
    var type:String;
    var audienceCount:Int;
    var uper:String;
    
    init(dataDic:NSDictionary) {
        title = dataDic.value(forKey:"title") as! String;
        imageName = dataDic.value(forKey: "imageName") as! String;
        let persons:String = dataDic.value(forKey: "audienceCount") as! String;
        audienceCount =  Int(persons)!;
        type = dataDic.value(forKey:"type") as! String;
        uper = dataDic.value(forKey: "uper") as! String;
    }
}
