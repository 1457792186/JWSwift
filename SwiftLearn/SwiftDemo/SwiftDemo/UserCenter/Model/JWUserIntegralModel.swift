//
//  JWUserIntegralModel.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import ObjectMapper

class JWUserIntegralModel: Mappable {
    var typeName: String?
    var addIntegral: String?
    var introduce: String?
    
//    var username: String?
//    var age: Int?
//    var weight: Double!
//    var array: [AnyObject]?
//    var dictionary: [String : AnyObject] = [:]
//    var bestFriend: User?                       // Nested User object
//    var friends: [User]?                        // Array of Users
//    var birthday: NSDate?
    
    //    MARK: - ObjectMapper
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        typeName <- map["typeName"]
        addIntegral <- map["addIntegral"]
        introduce <- map["introduce"]
    }
    
//    func mapping(map: Map) {
//        username    <- map["username"]
//        age         <- map["age"]
//        weight      <- map["weight"]
//        array       <- map["arr"]
//        dictionary  <- map["dict"]
//        bestFriend  <- map["best_friend"]
//        friends     <- map["friends"]
//        birthday    <- (map["birthday"], DateTransform())
//    }
    
}
