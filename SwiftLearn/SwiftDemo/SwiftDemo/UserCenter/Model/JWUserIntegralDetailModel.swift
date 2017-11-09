//
//  JWUserIntegralDetailModel.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWUserIntegralDetailModel: NSObject,Mappable {
    var typeName:String?
    var addIntegral:String?
    var time:String?
    
    //    MARK: - ObjectMapper
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        typeName <- map["typeName"]
        addIntegral <- map["addIntegral"]
        time <- map["time"]
    }
    
}
