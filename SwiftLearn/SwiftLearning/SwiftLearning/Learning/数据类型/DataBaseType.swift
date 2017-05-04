//
//  DataBaseType.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class DataBaseType: NSObject {
    func show() {
        /*
         Swift通过var进行变量定义，通过let进行常量定义（这和其他高级语言比较类似，例如F#）；
         Swift添加了类型推断，对于赋值的常量或者变量会自动推断其具体类型；
         Swift是强类型语言（应该说它比C#、Java等强类型语言控制还要严格），不同的数据类型之间不能隐式转化，如果需要转化只能强制转化；
         在Swift中类型转换直接通过其类型构造函数即可，降低了API的学习成本；
         
         Swift包含了C和ObjC语言中的所有基础类型，Int整形，Float和Double浮点型，Bool布尔型，Character字符型，String字符串类型；当然还包括enum枚举、struct结构体构造类型；Array数组、Set集合、Dictionary字典集合类型；不仅如此还增加了高阶数据类型元组（Tuple），可选类型（Optinal）。
         */
        var a:Int = 1 //通过var定义一个变量
        
        var b = 2  //变量b虽然没有声明类型，但是会自动进行类型推断，这里b推断为Int类型
        
        var c:UInt=3
        let d = a+b //通过let定义一个变量
        
        
        //下面通过"\()"实现了字符串和变量相加(字符串插值)，等价于print("d="+String(d))
        print("d=\(d)") //结果：d=3
        //注意由于Swift是强类型语言，a是Int类型而c是UInt类型，二者不能运算，下面的语句报错;但是注意如果是类似于：let a=1+2.0是不会报错的，因为两个都是字面量，Swift会首先计算出结果再推断a的类型
        //let e=a+c
        
        //Int.max是Int类型的最大值，类似还有Int.min、Int32.max、Int32.min等
        let e = Int.max //结果：9223372036854775807
        
        var f:Float=1.0//浮点型
        var g=2.0 //浮点型自动推断为Double类型
        
        var h:String="hello "
        
        //emoj表情也可以作为变量或者常量，事实上所有Unicode字符都是可以的
        var 💖🍎="love and apple"
        
        //两个字符串相加，但是注意不同类型不能相加
        var i=h+💖🍎 //结果:hello love and apple
        
        //布尔类型只有两个值true、false，类似于if语句中的条件只能是布尔类型不能像ObjC一样非0即真
        var j:Bool=true
        
        //字符类型，同样使用双引号，但是只能是一个字符，如果不指定类型则"c"默认会推断为字符串（var k:Character="c"是字符类型，但是var k="c"是字符串类型）
        var k:Character="c"
        
        var l=00100 //等于100，可以在前面添加额外的0
        var m=10_000_000 //等于10000000，可以使用增加额外的下划线方便阅读而不改变值的大小
        
        
        //Int转换Float或Double：
        let intVar : Int = 3
        let doubleVar : Double = Double(intVar)
        //Int转换为String：
        let intVar1 : Int = 3
        let strVar1 : String = String(intVar1)
        //String转换为Int：
        let strVar2 : String = "123"
        let intVar2 : Int? = Int(strVar2)
        //Double转换为String：
        let doubleVar3 : Double = 3.14
        let strVar3 : String = String(doubleVar)
        //Double保留两位小数，需要对Double进行扩展：
        //        extension Double {
        //            func format(f: String) -> String {
        //                return NSString(format: "%\(f)f", self)
        //            }
        //        }
        let myDouble = 1.234567
        print(myDouble.format(f: ".2"))//类扩展方法
        //String转换Double：
        let strVar5 : String = "3.14"
        var string5 = NSString(string: strVar5).doubleValue
    }
    
}
