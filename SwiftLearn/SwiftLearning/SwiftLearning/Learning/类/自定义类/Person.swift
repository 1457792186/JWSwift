//
//  Person.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class Person: NSObject {
    //定义属性
    var name:String
//    var height=0.0
    var height:Double
    var age=0
    
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
//    init(name:String){//var height=0.0已经定义默认参数时可写
//        self.name=name
//    }
    //指定构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String,height:Double,age:Int){
        self.name=name
        self.height=height
        self.age=age
    }
    
    /*
     方法就是与某个特定类关联的函数，其用法和前面介绍的函数并无二致，但是和ObjC相比，ObjC中的函数必须是C语言，而方法则必须是ObjC。此外其他语言中方法通常存在于类中，但是Swift中的方法除了在类中使用还可以在结构体、枚举中使用。关于普通的方法这里不做过多赘述，用法和前面的函数区别也不大，这里主要看一下构造方法
     */
    //定义方法
    func showMessage(){
        print("name=\(name),height=\(height)")
    }
    
    //便利构造方法，通过调用指定构造方法、提供默认值来简化构造方法实现（类似于类方法）
    convenience init(name:String){
        self.init(name:name,height:0.0,age:0)
    }
    
    //实例方法
    func modifyInfoWithAge(age:Int,height:Double){
        self.age=age
        self.height=height
    }
    
    //类型方法
    class func showClassName(){
        print("Class name is \"Person\"")
    }
    
    //析构方法，在对象被释放时调用,类似于ObjC的dealloc，注意此函数没有括号，没有参数，无法直接调用
    deinit{
        print("deinit...")
    }
}


//通过便利构造方法创建对象
var person = Person(name: "kenshin")
/*
 除构造方法、析构方法外的其他方法的参数默认除了第一个参数是局部参数，从第二个参数开始既是局部参数又是外部参数（这种方式和ObjC的调用方式很类似，当然，可以使用“#”将第一个参数同时声明为外部参数名，也可以使用“_”将其他参数设置为非外部参数名）。但是，对于函数，默认情况下只有默认参数既是局部参数又是外部参数，其他参数都是局部参数。
 构造方法的所有参数默认情况下既是外部参数又是局部参数；
 Swift中的构造方法分为“指定构造方法”和“便利构造方法（convenience）”，指定构造方法是主要的构造方法，负责初始化所有存储属性，而便利构造方法是辅助构造方法，它通过调用指定构造方法并指定默认值的方式来简化多个构造方法的定义，但是在一个类中至少有一个指定构造方法。
 */
