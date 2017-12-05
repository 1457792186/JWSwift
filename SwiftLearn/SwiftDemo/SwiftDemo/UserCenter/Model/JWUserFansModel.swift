//
//  JWUserFansModel.swift
//  SwiftDemo
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit
import ObjectMapper

class JWUserFansModel:NSObject,Mappable {
    var nickName:String?
    var dateStr:String?
    var userIcon:String?
    var userID:String?
    var userState:String?
    
    //    MARK: - ObjectMapper
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nickName <- map["nickName"]
        dateStr <- map["dateStr"]
        userIcon <- map["userIcon"]
        userID <- map["userID"]
        userState <- map["userState"]
    }
    
    class func initModel(dataDic:NSDictionary) -> JWUserFansModel {
        let dataJSON = JWTools.getJSONStringFromDictionary(dictionary: dataDic as NSDictionary)
        //        let model:[JWUserIntegralModel] = Mapper<JWUserIntegralModel>().mapArray(JSONString: dataJSON as String)!
        let model = Mapper<JWUserFansModel>().map(JSONString: dataJSON as String)
        model?.dateStr = JWTools.dateStr(commonDate: (model?.dateStr)!)
        return model!
    }
    
}
