//
//  StudentGood.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

//StudentGood继承于Student并且实现了Named协议
class StudentGood: Named {
    //以下皆为Named协议中内容
    
    //注意从Named协议中并不知道name是存储属性还是计算属性，这里将其作为存储属性实现
    var name:String
    
    //静态属性
    static var className:String{
        return "3·2班"
    }
    
    
    //协议中规定的构造方法，必须使用required关键字声明，除非类使用final修饰
    required init(name:String){
        self.name = name
    }
    
    //遵循showName方法
    func showName() {
        print("name=\(name)")
    }
    
    //遵循showClassName方法
    static func showClassName() {
        print("Class name is \"Person\"")
    }
}


//StudentGood继承于Student并且实现了Commented协议
class StudentBest: StudentGood,Commented{
    var commentStu:String
    
    init(name:String, commentStu:String){
        self.commentStu = commentStu
        super.init(name: name)
    }
    
    //遵循showName方法
    func showComment() {
        print("comment=\(commentStu)")
    }
    
    //协议中规定的构造方法，必须使用required关键字声明，除非类使用final修饰
    required init(name: String) {
        self.commentStu = "Good"
        super.init(name: name)
    }
}
