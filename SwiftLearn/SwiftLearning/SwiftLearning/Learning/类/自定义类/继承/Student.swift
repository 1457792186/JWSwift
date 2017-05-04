//
//  Student.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 和ObjC一样，Swift也是单继承的（可以实现多个协议，此时协议放在后面），子类可以调用父类的属性、方法，重写父类的方法，添加属性监视器，甚至可以将只读属性重写成读写属性
 */
/*
 在使用ObjC开发时init构造方法并不安全，首先无法保证init方法只调用一次，其次在init中不能访问属性。但是这些完全依靠文档约定，编译时并不能发现问题，出错检测是被动的。在Swift中构造方法(init)有了更为严格的规定：构造方法执行完之前必须保证所有存储属性都有值。这一点不仅在当前类中必须遵循，在整个继承关系中也必须保证，因此就有了如下的规定：
 
 子类的指定构造方法必须调用父类构造方法，并确保调用发生在子类存储属性初始化之后。而且指定构造方法不能调用同一个类中的其他指定构造方法；
 便利构造方法必须调用同一个类中的其他指定构造方法（可以是指定构造方法或者便利构造方法），不能直接调用父类构造方法（用以保证最终以指定构造方法结束）；
 如果父类仅有一个无参构造方法（不管是否包含便利构造方法），子类的构造方法默认就会自动调用父类的无参构造方法（这种情况下可以不用手动调用）；
 常量属性必须默认指定初始值或者在当前类的构造方法中初始化，不能在子类构造方法中初始化
 */
class Student: PersonWithProperty {
    //重写属性监视器
    override var firstName:String{
        willSet{
            print("oldValue=\(firstName)")
        }
        didSet{
            print("newValue=\(firstName)")
        }
    }
    
    var score:Double
    
    //子类指定构造方法一定要调用父类构造方法
    //并且必须在子类存储属性初始化之后调用父类构造方法
    init(firstName:String,lastName:String, score:Double){
        self.score=score
        super.init(firstName: firstName, lastName: lastName, age: 10)
    }
    
    convenience init(){
        self.init(firstName:"",lastName:"",score:0)
    }
    
    //将只读属性重写成了可写属性
    override var fullName:String{
        get{
            return super.fullName;
        }
        set{
            let array = ["Jack","Json"]
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
        }
    }
    
    //重写方法
    override func showMessage() {
        print("name=\(fullName),age=\(age),score=\(score)")
    }
    
}
