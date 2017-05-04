//
//  WhileForClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class WhileForClass: NSObject {
    func show() {
        /*
         Swift中的多数控制流和其他语言差别并不大，例如for、while、do while、if、switch等，而且有些前面已经使用过（例如for in循环），这里将着重介绍一些不同点
         */
        var afor=["a","b","c","d","e","f","g"]
        let bfor=afor[1]
        /**
         *  switch支持一个case多个模式匹配，同时case后不用写break也会在匹配到种情况后自动跳出匹配，不存在隐式贯穿，如果想要贯穿在case之后添加"fallthrough"关键字
         */
        switch bfor{
        case "a","b":
            print("b=a or b=b")
        case "c","d","e","f":
            print("b in (c,d,e,f)")
        default:
            print("b=g")
        }
        
        /**
         * 匹配区间,同时注意switch必须匹配所有情况，否则必须加上default
         */
        
        let cfor:Int=88
        switch cfor{
        case 1...60:
            print("1-60")
        case 61...90:
            print("61-90")
        case 91...100:
            print("91-100")
        default:
            print("1>c>100")
        }
        
        /**
         *  元组匹配、值绑定、where条件匹配
         *  注意下面的匹配没有default，因为它包含了所有情况
         */
        var dfor=(x:900,y:0)
        switch dfor{
        case (0,0):
            print("d in (0,0)")
        case (_,0): //忽略x值匹配
            print("d in y")
        case (0,let y)://值绑定
            print("d in x,y=\(y)")
        case (-100...100,-100...100): //注意这里有可能和第一、二、三个条件重合，但是Swift允许多个case匹配同一个条件，但是只会执行第一个匹配
            print("x in（0-100），y in （0-100）")
        case let (x,y) where x==y: //where条件匹配,注意这里的写法等同于：(let x,let y) where x==y
            print("x=y=\(x)")
        case let (x, y):
            print("x=\(x),y=\(y)")
            
        }
        
        
        /*
         在其他语言中通常可以使用break、continue、return（Swift中添加了fallthrough）等来终止或者跳出某个执行语句，但是对于其行为往往是具有固定性的，例如break只能终止其所在的内层循环，而return只能跳出它所在的函数。在Swift中这种控制转移功能得到了加强，那就是使用标签。利用标签你可以随意指定转移的位置
         */
        var aBreak=5
        whileLoop:
            while aBreak > 0 {
                for i in 0 ..< aBreak{
                    print("a=\(aBreak),i=\(i)")
                    
                    break whileLoop
                    //如果此处直接使用break将跳出for循环，而由于这里使用标签直接跳出了while，结果只会打印一次，其结果为：a=4,i=0
                }
                aBreak -= 1
        }
    }
}
