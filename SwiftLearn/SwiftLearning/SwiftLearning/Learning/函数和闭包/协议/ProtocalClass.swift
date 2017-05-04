//
//  ProtocalClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 协议是对实例行为的一种约束，和ObjC类似，在Swift中可以定义属性和方法（ObjC中之所以能定义属性是因为@property的本质就是setter、getter方法）。和其他语言不同的是Swift中的协议不仅限于类的实现，它同样可以应用于枚举、结构体（如果只想将一个协议应用于类，可以在定义协议时在后面添加class关键字来限制其应用范围）
 */

protocol Named{
    //定义一个实例属性
    var name:String { get set }
    
    //定义一个类型属性
    static var className:String { get }
    
    //定义构造方法
    init(name:String)
    
    //定义一个实例方法
    func showName()
    
    //定义一个类型方法
    static func showClassName()
}

protocol Commented{
    var commentStu:String { get set }
    
    //定义一个实例方法
    func showComment()
}

// MARK: - 协议中的可选方法
@objc protocol MyProtocol {
    @objc optional func func1() //old: optional func func1()
    func func2()
}


// MARK: - ProtocalClass遵循了Named协议
class ProtocalClass: Named {
    //注意从Named协议中并不知道name是存储属性还是计算属性，这里将其作为存储属性实现
    var name:String
    
    var age:Int = 0
    
    static var className:String{
        return "Person"
    }
    
    //协议中规定的构造方法，必须使用required关键字声明，除非类使用final修饰
    required init(name:String){
        self.name=name
    }
    
    //遵循showName方法
    func showName() {
        print("name=\(name)")
    }
    
    //遵循showClassName方法
    static func showClassName() {
        print("Class name is \"Person\"")
    }
}
