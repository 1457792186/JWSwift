//
//  ExtensionDoubleClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit
// MARK: - 类扩展-------double转str
extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f" as NSString,self) as String
    }
}

class ExtensionDoubleClass: NSObject {

}


/*
 Swift中的扩展就类似于ObjC中的分类（事实上在其他高级语言中更多的称之为扩展而非分类），但是它要比分类强大的多，它不仅可以扩展类还可以扩展协议、枚举、结构体，另外扩展也不局限于扩展方法（实例方法或者类型方法），还可以扩展便利构造方法、计算属性、下标脚本
 */


class Child {
    var firstName:String,lastName:String
    var age:Int=0
    var fullName:String{
        get{
            return firstName+" "+lastName
        }
    }
    
    init(firstName:String,lastName:String){
        self.firstName=firstName
        self.lastName=lastName
    }
    
    func showMessage(){
        print("name=\(fullName),age=\(age)")
    }
}

extension Child{
    //只能扩展便利构造方法，不能扩展指定构造方法
    convenience init(){
        self.init(firstName:"",lastName:"")
    }
    
    //只能扩展计算属性，无法扩展存储属性
    var personInfo:String{
        return "firstName=\(firstName),lastName=\(lastName),age=\(age)";
    }
    
    //扩展实例方法
    func sayHello(){
        print("hello world.")
    }
    
    //嵌套类型
    enum SkinColor{
        case Yellow,White,Black
    }
    
    //扩展类型方法
    static func skin()->[SkinColor]{
        return [.Yellow,.White,.Black]
    }
}
