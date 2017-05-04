//
//  PersonWithProperty.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

// MARK: - 属性
/*
 Swift中的属性分为两种：存储属性（用于类、结构体）和计算属性（用于类、结构体、枚举），并且在Swift中并不强调成员变量的概念。 无论从概念上还是定义方式上来看存储属性更像其他语言中的成员变量，但是不同的是可以控制读写操作、通过属性监视器来属性的变化以及快速实现懒加载功能
 */

class Account {
    var balance:Double=0.0
    
    /*
     计算属性并不直接存储一个值，而是提供getter来获取一个值，或者利用setter来间接设置其他属性；
     lazy属性必须有初始值，必须是变量不能是常量（因为常量在构造完成之前就已经确定了值）；
     在构造方法之前存储属性必须有值，无论是变量属性（var修饰）还是常量属性（let修饰）这个值既可以在属性创建时指定也可以在构造方法内指定
     
     上面的例子中不难区分存储属性和计算属性，计算属性通常会有一个setter、getter方法，如果要监视一个计算属性的变化在setter方法中即可办到（因为在setter方法中可以newValue或者自定义参数名），但是如果是存储属性就无法通过监视属性的变化过程了，因为在存储属性中是无法定义setter方法的。不过Swift为我们提供了另外两个方法来监视属性的变化那就是willSet和didSet，通常称之为“属性监视器”或“属性观察器”
     */
    
    var balanceCount:Double=0.0{
        willSet{
            self.balance=2.0
            //注意newValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用,注意此时修改balance的值没有用
            print("Account.balance willSet,newValue=\(newValue),value=\(self.balance)")
        }
        didSet{
            self.balance=3.0
            //注意oldValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用，注意此时修改balance的值将作为最终结果
            print("Account.balance didSet,oldValue=\(oldValue),value=\(self.balance)")
        }
    }
    /*
     和setter方法中的newValue一样，默认情况下载willSet和didSet中会有一个newValue和oldValue参数表示要设置的新值和已经被修改过的旧值（当然参数名同样可以自定义）；
     存储属性的默认值设置不会引起属性监视器的调用（另外在构造方法中赋值也不会引起属性监视器调用），只有在外部设置存储属性才会引起属性监视器调用；
     存储属性的属性监视器willSet、didSet内可以直接访问属性，但是在计算属性的get、set方法中不能直接访问计算属性，否则会引起循环调用；
     在didSet中可以修改属性的值，这个值将作为最终值（在willSet中无法修改）；
     */
}


class PersonWithProperty: NSObject {
    //firstName、lastName、age是存储属性
    var firstName:String
    var lastName:String
    
    let age:Int
    
    //fullName是一个计算属性，并且由于只定义了get方法，所以是一个只读属性
    //如果fullName只有get则是一个只读属性，只读属性可以简写如下：
    var fullName:String{
        return firstName + "." + lastName
    }
    //若需要修改，需要以下方法
    var fullNameCanWrite:String{
        get{
            return firstName + "." + lastName
        }
        set{
            var array = ["hello","world"]
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
            
        }
//        set方法中的newValue表示即将赋的新值，可以自己设置set中的newValue变量，如下：
//        set(myValue){
//        }
    }

    
    //属性的懒加载，第一次访问才会计算初始值，在Swift中懒加载的属性不一定就是对象类型，也可以是基本类型
    lazy var account = Account()
    
    
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    //需要加上age,因为age未赋默认值,若要去除,初始化时需要改成var age:Int=0
    init(firstName:String,lastName:String,age:Int){
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
    }
    
    //类型属性
    static var skin:Array<String>{
        return ["yellow","white","black"];
    }
    
    
    //定义方法
    func showMessage(){
        print("name=\(fullName),age=\(age)")
    }
    
    //通过final声明，子类无法重写
    final func sayHello(){
        print("hello world.")
    }
}
