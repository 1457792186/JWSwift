//
//  CaculateClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class CaculateClass: NSObject {
    func show() {
        /*
         Swift中的闭包其实就是一个函数代码块，它和ObjC中的Block及C#、Java中的lambda是类似的。闭包的特点就是可以捕获和存储上下文中的常量或者变量的引用，即使这些常量或者变量在原作用域已经被销毁了在代码块中仍然可以使用。事实上前面的全局函数和嵌套函数也是一种闭包，对于全局函数它不会捕获任何常量或者变量，而对于嵌套函数则可以捕获其所在函数的常量或者变量。通常我们说的闭包更多的指的是闭包表达式，也就是没有函数名称的代码块，因此也称为匿名闭包
         在Swift中闭包表达式的定义形式如下：
         { ( parameters ) -> returnType in
         
         statements
         
         }
         */
        func sum(num1:Int,num2:Int)->Int{
            return num1 + num2
        }
        
        func minus(num1:Int,num2:Int)->Int{
            return num1 - num2
        }
        
        func caculate(num1:Int,num2:Int,fn:(Int,Int)->Int)->Int{
            return fn(num1,num2)
        }
        
        var (a,b)=(1,2)
        
        
        caculate(num1: a, num2: b, fn: sum) //结果：3
        caculate(num1: a, num2: b, fn: minus) //结果：-1
        
        //利用闭包表达式简化闭包函数
        caculate(num1: a, num2: b, fn: {(num1:Int,num2:Int)->Int in
            return num1 - num2
        }) //结果：-1
        
        //简化形式,根据上下文推断类型并且对于单表达式闭包（只有一个语句）可以隐藏return关键字
        caculate(num1: a, num2: b, fn: { num1,num2 in
            num1 - num2
        }) //结果：-1
        
        //再次简化，使用参数名缩写,使用$0...$n代表第n个参数，并且此in关键字也省略了
        caculate(num1: a, num2: b, fn: {
            $0 - $1
        }) //结果：-1
        
        /*考虑到闭包表达式的可读取性，Swift中如果一个函数的最后一个参数是一个函数类型的参数（或者说是闭包表达式），则可以将此参数写在函数括号之后，这种闭包称之为“尾随闭包”*/
        func sum3(num1:Int,num2:Int)->Int{
            return num1 + num2
        }
        
        func minus2(num1:Int,num2:Int)->Int{
            return num1-num2
        }
        
        func caculate1(num1:Int,num2:Int,fn:(Int,Int)->Int)->Int{
            return fn(num1,num2)
        }
        
        var (a22,b22)=(1,2)
        
        //尾随闭包，最后一个参数是闭包表达式时可以卸载括号之后，同时注意如果这个函数只有一个闭包表达式参数时可以连通括号一块省略
        //请注意和函数定义进行区分
        caculate1(num1: a22, num2: b22){
            $0 - $1
        } //结果：-1
        
        
        /*
         前面说过闭包之所以称之为“闭包”就是因为其可以捕获一定作用域内的常量或者变量进而闭合并包裹着
         */
        func add()->()->Int{
            var total=0
            var step=1
            func fn()->Int{
                total+=step
                return total
            }
            return fn
        }
        
        //fn捕获了total和step，尽管下面的add()执行完后total和step被释放，但是由于fn捕获了二者的副本，所以fn会随着两个变量的副本一起被存储
        var a_fun=add()
        a_fun() //结果：1
        a_fun() //结果：2，说明a中保存了total的副本（否则结果会是1）
        
        var b_fun=add()
        b_fun() //结果：1 ，说明a和b单独保存了total的副本（否则结果会是3）
        
        var c_fun=b_fun
        c_fun() //结果：2，说明闭包是引用类型，换句话说函数是引用类型（否则结果会是1）
        /*
         Swift会自动决定捕获变量或者常量副本的拷贝类型（值拷贝或者引用拷贝）而不需要开发者关心，另外被捕获的变量或者常量的内存管理同样是由Swift来管理，例如当上面的函数a不再使用了那么fn捕获的两个变量也就释放了
         */
    }
}
