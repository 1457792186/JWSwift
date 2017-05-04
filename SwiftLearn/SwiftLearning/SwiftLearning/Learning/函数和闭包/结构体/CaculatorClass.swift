//
//  CaculatorClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

// MARK: - 结构体
struct Caculator {
    func sum(a:Int,b:Int) -> Int {
        return a + b
    }
    
    @discardableResult
    func func1(a:Int,b:Int) ->Int {
        return a - b + 1
    }
}

func showCaculator() {
    let ca = Caculator()
    ca.sum(a: 1, b: 2) // 此处会警告，因为方法有返回值但是没有接收
    let _ = ca.sum(a: 1, b: 2) // 使用"_"接收无用返回值
    ca.func1(a: 1, b: 2) // 由于func1添加了@discardableResult声明，即使不接收返回值也不会警告
}

class CaculatorClass: NSObject {
    
}


/*
 结构体和类是构造复杂数据类型时常用的构造体，在其他高级语言中结构体相比于类要简单的多（在结构体内部仅仅能定义一些简单成员），但是在Swift中结构体和类的关系要紧密的多，这也是为什么将结构体放到后面来说的原因。Swift中的结构体可以定义属性、方法、下标脚本、构造方法，支持扩展，可以实现协议等等，很多类可以实现的功能结构体都能实现，但是结构体和类有着本质区别：类是引用类型，结构体是值类型。
 */

struct Man {
    var firstName:String
    var lastName:String
    
    var fullName:String{
        return firstName + " " + lastName
    }
    
    var age:Int=0
    
    //构造函数，如果定义了构造方法则不会再自动生成默认构造函数
    //    init(firstName:String,lastName:String){
    //        self.firstName=firstName
    //        self.lastName=lastName
    //    }
    
    func showMessage(){
        print("firstName=\(firstName),lastName=\(lastName),age=\(age)")
    }
    
    //注意对于类中声明类型方法使用关键字class修饰，但结构体里使用static修饰
    static func showStructName(){
        print("Struct name is \"Person\"")
    }
}
/*
 默认情况下如果不自定义构造函数那么将自动生成一个无参构造函数和一个全员的逐一构造函数；
 由于结构体是值类型，所以它虽然有构造函数但是没有析构函数，内存释放系统自动管理不需要开发人员过多关注；
 类的类型方法使用class修饰（以便子类可以重写），而结构体、枚举的类型方法使用static修饰(补充：类方法也可以使用static修饰，但是不是类型方法而是静态方法；另外类的存储属性如果是类型属性使用static修饰，而类中的计算属性如果是类型属性使用class修饰以便可以被子类重写；换句话说class作为“类型范围作用域”来理解时只有在类中定义类型方法或者类型计算属性时使用，其他情况使用static修饰[包括结构体、枚举、协议和类型存储属性])；
 */



