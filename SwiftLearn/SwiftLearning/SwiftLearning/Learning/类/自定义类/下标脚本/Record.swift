//
//  Record.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 下标脚本是一种访问集合的快捷方式，例如：var a:[string],我们经常使用a[0]、a[1]这种方式访问a中的元素，0和1在这里就是一个索引，通过这种方式访问或者设置集合中的元素在Swift中称之为“下标脚本”（类似于C#中的索引器）。从定义形式上通过“subscript”关键字来定义一个下标脚本，很像方法的定义，但是在实现上通过getter、setter实现读写又类似于属性。假设用Record表示一条记录，其中有多列，下面示例中演示了如何使用下标脚本访问并设置某一列的值
 */
class Record: NSObject {
    //定义属性，假设store是Record内部的存储结构
    var store:[String:String]
    
    init(data:[String:String]){
        self.store=data
    }
    
    //下标脚本（注意也可以实现只有getter的只读下标脚本）
    subscript(index:Int)->String{
        get{
            var key=self.store.keys.sorted()[index]
            return self.store[key]!
        }
        set{
            var key=self.store.keys.sorted()[index]
            self.store[key]=newValue //newValue参数名可以像属性一样重新自定义
        }
    }
    
    //下标脚本（重载）
    subscript(key:String)->String{
        get{
            return store[key]!
        }
        set{
            store[key]=newValue
        }
    }
}
