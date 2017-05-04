//
//  StackClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 泛型可以让你根据需求使用一种抽象类型来完成代码定义，在使用时才真正知道其具体类型。这样一来就好像在定义时使用一个占位符做一个模板，实际调用时再进行模板套用，所以在C++中也称为“模板”。泛型在Swift中被广泛应用，上面介绍的Array<>、Dictionary<>事实上都是泛型的应用。通过下面的例子简单看一下泛型参数和泛型类型的使用。
 */
/*泛型参数*/
//添加了约束条件的泛型（此时T必须实现Equatable协议）
func isEqual<T:Equatable>(a:T,b:T)->Bool{
    return a == b
}

protocol Stackable{
    //声明一个关联类型
    associatedtype ItemType
    mutating func push(item:ItemType)
    mutating func pop()->ItemType;
}

struct Stack:Stackable{
    typealias ItemType = String
    
    var store:[ItemType]=[]
    
    mutating func push(item:ItemType){
        store.append(item)
    }
    
    mutating func pop()->ItemType{
        return store.removeLast()
    }
}

func show() {
    //MARK:-泛型
    var a:Int=1,b:Int=2
    print(isEqual(a: a,b: b)) //结果：false
    
    var c:String="abc",d:String="abc"
    print(isEqual(a: c,b: d)) //结果：true
    
    /*泛型类型*/
    struct Stack<T> {
        var store:[T]=[]
        
        //在结构体、枚举中修改其变量需要使用mutating修饰（注意类不需要）
        mutating func push(item:T){
            store.append(item)
        }
        
        mutating func pop()->T{
            return store.removeLast()
        }
    }
    
    var s = Stack<Int>()
    s.push(item: 1)
    let t = s.pop()
    print("t=\(t)") //结果：t=1
    
    
    //    //扩展泛型类型
    //    extension Stack{
    //        var top:T?{
    //            return store.last
    //        }
    //    }
    //
    //    s.push(item: 2)
    //    print(s.top!) //结果：2
    
    
    
    var s1 = Stack<String>()
//    var s1 = Stack<T>()
    s1.push(item: "hello")
    s1.push(item: "world")
    let t1 = s1.pop()
    print("t1=\(t1)") //结果：t=world
}


class StackClass: NSObject {
    
}
