//
//  BaseClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 作为一门面向对象语言，类当然是Swift中的一等类型。通过下面的例子让大家对Swift的class有一个简单的印象，在下面的例子中可以看到Swift中的属性、方法（包括构造方法和析构方法）
 */
//Swift中一个类可以不继承于任何其他基类，那么此类本身就是一个基类

// MARK: - 类中再自定义类
class CountFunClass{
    
    // 从第一个参数就必须指定参数名，除非使用"_"明确指出省略参数
    @objc func sum(num1:Int,num2:Int)->Int{
        return num1 + num2
    }
    
    
    func func1(){//调用方法
        let _ = #selector(sum(num1:num2:))
    }
    
    
    //取消var参数
    func increase(a:Int){
        var a = a
        a += 1
    }
    
    
    //inout参数修饰改放到类型前
    func increase( a:inout Int) {
        a += 1
    }
    
    func otherSelector(){
        //取消++、--操作符
        var d = 1
        d += 1 //d++报错,可以改写成 d += 1 或者 d = d + 1
        
        
        //取消C风格for循环
        for i in 0  ..< 10  {
            debugPrint(i)
        }
    }
}


//MARK:-调用自定义类
class BaseClass: NSObject {
    func show() {
        //MARK:-例1Person
        var p = Person(name: "Kenhin")
        p.height=172.0
        p.showMessage() //结果：name=Kenhin,height=172.0
        
        //类是引用类型
        var p2 = p
        p2.name = "Kaoru"
        print(p.name) //结果：Kaoru
        if p === p2 { //“===”表示等价于，这里不能使用等于“==”（等于用于比较值相等，p和p2是不同的值，只是指向的对象相同）
            print("p===p2") //p等价于p2,二者指向同一个对象
        }
        /*
         从上面的例子不难看出：
         Swift中的类不必须继承一个基类（但是ObjC通常必须继承于NSObject），如果一个类没有继承于任何其他类则这个类也称为“基类”；
         Swift中的属性定义形式类似于其他语句中的成员变量（或称之为“实例变量”），尽管它有着成员变量没有的特性；
         Swift中如果开发者没有自己编写构造方法那么默认会提供一个无参数构造方法（否则不会自动生成构造方法）；
         Swift中的析构方法没有括号和参数，并且不支持自行调用；
         */
        
        
        //MARK:-例2PersonWithProperty加属性
        var pWithProperty=PersonWithProperty(firstName: "Kenshin", lastName: "Cui",age:29)
        //pWithProperty.fullName="Kaoru.Sun"写入会报错,因为是只读属性,若要修改,需要改成可写属性,如PersonWithProperty的fullNameCanWrite属性
        pWithProperty.fullNameCanWrite="Kaoru.Sun"
        pWithProperty.account.balance=10
        pWithProperty.account.balanceCount=10
        print("pWithProperty.account.balance=\(pWithProperty.account.balanceCount)") //录入属性时计算属性,结果：pWithProperty.account.balanceCount=30.0
        pWithProperty.showMessage()
        for color in PersonWithProperty.skin {
            print(color)
        }
        
        
        //MARK:-下标脚本调用
        var r=Record(data:["name":"kenshin","sex":"male"])
        print("r[0]=\(r[0])") //结果：r[0]=kenshin
        r["sex"]="female"
        print(r[1]) //结果：female
        
        
        
        //MARK:-协议调用
        /*
         协议中虽然可以指定属性的读写，但即使协议中规定属性是只读的但在使用时也可以将其实现成可读写的；
         Swift的协议中可以约定属性是实例属性还是类型属性、是读写属性还是只读属性，但是不能约束其是存储属性还是计算属性;
         协议中的类型属性和类型方法使用static修饰而不是class（尽管对于类的实现中类型属性、类型方法使用class修饰）;
         协议中约定的方法支持可变参数，但是不支持默认参数;
         协议中约定的构造方法，在实现时如果不是final类则必须使用require修饰（以保证子类如果需要自定义构造方法则必须覆盖父类实现的协议构造方法，如果子类不需要自定义构造方法则不必）;
         一个协议可以继承于另外一个或多个协议，一个类只能继承于一个类但可以实现多个协议；
         协议本身就是一种类型，这也体现除了面向对象的多态特征，可以使用多个协议的合成来约束一个实例参数必须实现某几个协议；
         */
        var stuGood = StudentGood.init(name: "JW")
        stuGood.showName() //结果：name=JW
        print("className=\(StudentGood.className)") //结果：className=3·2班
        StudentGood.showClassName() //结果：Class name is "3·2班"
        stuGood.name = "WJ"
        
        
        var stu:Commented = StudentBest(name:"YZ", commentStu:"BEST") //尽管这里将s声明为Named类型，但是运行时仍然可以正确的解析（多态）,但是注意此时编译器并不知道s有test方法，所以此时调用test()会报错
        stu.showComment()
        
        
        //在下面的函数中要求参数stu必须实现两个协议
        func showMessage(stu:Named & Commented){
            print("name=\(stu.name),comment=\(stu.commentStu)")
        }
        var stuBetter = StudentBest(name:"JW", commentStu:"BETTER");
        showMessage(stu: stuBetter)
        
        
        //检测协议
        let stuTest = stu is Named //判断p是否遵循了Scored协议
        if stuTest {
            print("s has name property.")
        }
        //类型转化
        if let stuTurn = stu as? Named { //如果s转化成了Scored类型则返回实例，否则为nil
            print("stuTurn' name is \(stuTurn.name)") //结果：s3' score is 100.0
        }
        let stuTurnFaild =  stu as! Named //强制转换，如果转化失败则报错
        print("stuTurnFaild' name is \(stuTurnFaild.name)") //结果：s4' score is 100.0
        
        
        
        //MARK:-类扩展
        var children = Child()
        children.firstName="Kenshin"
        children.lastName="Cui"
        children.age=28
        print(children.personInfo) //结果：firstName=Kenshin,lastName=Cui,age=28
        children.sayHello() //结果：hello world.
        Child.skin()
        
        
        //MARK:-结构体
        //注意所有结构体默认生成一个全员逐一构造函数,一旦自定义构造方法，这个默认构造方法将不会自动生成
        var man = Man(firstName: "Kenshin", lastName: "Cui", age: 28)
        print(man.fullName) //结果：Kenshin Cui
        man.showMessage() //结果：firstName "Kenshin", lastName "Cui", age 28
        Man.showStructName() //结果：Struct name is "Person"
        
        //由于结构体（包括枚举）是值类型所以赋值、参数传递时值会被拷贝(所以下面的实例中p2修改后p并未修改，但是如果是类则情况不同)
        var men = man
        men.firstName = "Tom"
        print(men.fullName) //结果：Tom Cui
        print(men.fullName) //结果：Kenshin Cui
        
        
        
        //MARK:-枚举
        //1.基本型
        var season = Season.Spring
        
        //一旦确定了枚举类型，赋值时可以去掉类型实现简写
        season = .Summer
        
        switch season {
        case .Spring: //由于Swift的自动推断，这里仍然可以不指明类型
            print("spring")
        case .Summer:
            print("summer")
        case .Autumn:
            print("autumn")
        default:
            print("winter")
        }
        
        
        //2.指定原始值
        var summer = SeasonWithOrigion.Summer
        
        //使用rawValue访问原始值
        print("summer=\(summer),rawValue=\(summer.rawValue)")
        
        //通过原始值创建枚举类型，但是注意它是一个可选类型
        var autumn = SeasonWithOrigion(rawValue: 12)
        
        //可选类型绑定
        if let newAutumn=autumn{
            print("summer=\(newAutumn),rawValue=\(newAutumn.rawValue)")
        }
        
        //3.相关值
        var red=Color.RGB("#FF0000")
        
        var green=Color.CMYK(0.61, 0.0, 1.0, 0.0)
        
        var blue=Color.HSB(240, 100, 100)
        
        switch red {
        case .RGB(let colorStr):
            print("colorStr=\(colorStr)")
        case let .CMYK(c,m,y,k):
            print("c=\(c),m=\(m),y=\(y),k=\(k)")
        case let .HSB(h,s,b):
            print("h=\(h),s=\(s),b=\(b)")
        }
        
        //4.带方法
        var summerWithFun=SeasonWithFun.Summer
        print(summerWithFun.tag) //结果：1
        print(SeasonWithFun.enumName) //结果：Season
        SeasonWithFun.showEnumName() //结果：Enum name is "Season"
        summerWithFun.showMessage() //结果：rowValue=1
        
        if let springWithFun = SeasonWithFun(prefix: "au") { //可选绑定，构造函数返回值可能为nil
            print(springWithFun.tag) //结果：2
        }
        
        
    }
}




