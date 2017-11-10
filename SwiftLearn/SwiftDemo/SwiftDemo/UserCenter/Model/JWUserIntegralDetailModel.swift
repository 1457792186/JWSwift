//
//  JWUserIntegralDetailModel.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import Foundation
import ObjectMapper

class JWUserIntegralDetailModel: NSObject,Mappable {
    var typeName: String?
    var addIntegral: String?
    var time: String?
    
    //    MARK: - ObjectMapper
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        typeName <- map["typeName"]
        addIntegral <- map["addIntegral"]
        time <- map["time"]
    }
    
    class func initModel(dataDic:NSDictionary) -> JWUserIntegralDetailModel {
        let dataJSON = JWTools.getJSONStringFromDictionary(dictionary: dataDic as NSDictionary)
        //        let model:[JWUserIntegralModel] = Mapper<JWUserIntegralModel>().mapArray(JSONString: dataJSON as String)!
        let model = Mapper<JWUserIntegralDetailModel>().map(JSONString: dataJSON as String)
        model?.time = JWTools.dateStr(commonDate: (model?.time)!)
        return model!
    }
}
