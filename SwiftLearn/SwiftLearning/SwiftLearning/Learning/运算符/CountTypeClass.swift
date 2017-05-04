//
//  CountTypeClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class CountTypeClass: NSObject {
    func show() {
        /*
         Swift中支持绝大多数C语言的运算符并改进以减少不必要的错误（例如等号赋值后不返回值），算术运算会检查溢出情况，必要时还能使用新增的溢出运算符。另外Swift中还可以对浮点数使用取余运算符，新增了区间运算符。对于基本的运算符这里不再一一介绍，简单看一下Swift中的区间运算符和溢出运算符
         */
        /**
         * 区间运算符,通常用于整形或者字符范围(例如"a"..."z"）
         */
        for i in 1...5 { //闭区间运算符...（从1到5，包含5）
            print("i=\(i)")
        }
        
        for i in 1..<5{ //半开区间运算符..<(从1到4)
            print("i=\(i)")
        }
        
        var strArr = "hello world."
        var range = "a"..."z"
        //        for t in strArr {
        //            if range.contains(String(t)) {
        //                print(t) //结果：helloworld
        //            }
        //        }
        
        /*溢出运算符
         溢出运算符的原理其实很简单，例如对于UInt8，如果8位均为1则十进制表示是255，但是当加1之后则变成了9位“100000000”，出现了溢出但是UInt8本身值只能存储8位，所以取后面8位就变成了“00000000”，十进制表示就是0
         */
        var a_Max=UInt8.max //a=255
        //var b:UInt8=a+1 //注意b会出现溢出,此句报错
        
        //下面使用溢出运算符，结果为：0，类似的还有&-、&*、&/
        //使用溢出运算符可以在最大值和最小值之前循环而不会报错
        var b_Max:UInt8 = a_Max &+ 1
    }
}
