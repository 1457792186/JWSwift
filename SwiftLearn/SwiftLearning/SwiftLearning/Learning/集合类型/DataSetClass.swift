//
//  DataSetClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class DataSetClass: NSObject {
    func show() {
        /*
         Swift提供了三种集合类型：数组Array、集合Set、字典Dictionary。和ObjC不同的是，由于Swift的强类型，集合中的元素必须是同一类型，而不能像ObjC一样可以存储任何对象类型,并且注意Swift中的集合是值类型而非引用类型（事实上包括String、结构体struct、枚举enum都是值类型）
         */
        
        // MARK: - Array
        //声明数组的时候必须确定其类型，下面使用[String]声明一个字符串数组（[String]是Array<String>简单表达形式）
        //var a:Array<String>=["hello","world"]
        var arr:[String]=["hello","world"]
        _ = arr[0] //访问数组元素
        
        //下面创建一个Double类型的数组，这里没有使用字面量，当前是一个空数组，当然也可以写成var b:[Double]=[]
        var arr_b=[Double]()
        
        for i in arr{
            print("arr i=\(i)")
        }
        
        //添加元素，Swift中可变类型不再由单独的一个类型来表示，统统使用Array，如果想声明为不可变数组只要使用let定义即可
        arr.append("!")
        
        arr+=["I" ,"am" ,"Kenshin"] //追加元素
        
        print("arr.count=\(arr.count)") //结果：a.count=6
        
        arr[3...5]=["I","Love","Swift"] //修改元素,但是注意无法用这种方式添加元素
        //a[6]=["."]//这种方式是错误的
        
        arr.insert("New", at: 5) //插入元素：hello world! I Love New Swift
        
        arr.remove(at: 5) //删除指定元素
        
        //使用全局enumerate函数遍历数据索引和元素
        for (index,element) in arr.enumerated(){
            print("index=\(index),element=\(element)")
        }
        
        //使用构造函数限制数组元素个数并且指定默认值,等价于var c=Array(count: 3, repeatedValue: 1)，自动推断类型
        var arrThreeValue = [Int](repeatElement(1, count: 3))
        
        
        
        // MARK: - Set表示没有顺序的集合
        //注意集合没有类似于数组的简化形式，例如不能写成var a:[String]=["hello","world"]
        var set_a:Set<String>=["hello","world"]
        var set_b:Set=[1,2] //类型推断：Set<Int>
        
        set_a.insert("!") //注意这个插入不保证顺序
        
        if !set_a.isEmpty { //判断是否为空
            set_a.remove("!")
        }
        
        if !set_a.contains("!"){
            set_a.insert("!")
        }
        
        
        // MARK: - Dictionary
        /*
         Dictionary字典同样是没有顺序的，并且在Swift中字典同样要在使用时明确具体的类型。和ObjC中一样，字典必须保证key是唯一的，而这一点就要求在Swift中key必须是可哈希的，不过幸运的是Swift中的基本类型（如Int、Float、Double、Bool、String）都是可哈希的，都可以作为key。
         在Swift中集合的可变性不是像ObjC一样由单独的数据类型来控制的，而是通过变量和常量来控制，这一点和其他高级语言比较类似
         */
        
        //通过字面量进行字典初始化，注意等价于var a:Dictionary<Int,String>=[200:"success",404:"not found"]
        var dic_a:[Int:String]=[200:"success",404:"not found"]
        var dic_b=[200:"success",404:"not found"] //不声明类型，根据值自动推断类型
        
        _ = dic_a[200] //读取字典
        dic_a[404]="can not found" //修改
        
        dic_a[500]="internal server error" //添加
        //a=[:] //设置为空字典,等价于：a=[Int:String]()
        
        for code in dic_a.keys{
            print("code=\(code)")
        }
        
        for description in dic_a.values{
            print("description=\(description)")
        }
        
        for (code,description) in dic_a{
            print("code=\(code),description=\(description)")
        }
        
        
        
        // MARK: - 元组（Tuple）
        /*
         在开发过程中有时候会希望临时组织一个数据类型，此时可以使用一个结构体或者类，但是由于这个类型并没有那么复杂，如果定义起来又比较麻烦，此时可以考虑使用元组
         */
        var point=(x:50,y:100) //自动推断其类型：(Int,Int)
        _ = point.x //可以用类似于结构体的方式直接访问元素,结果：50
        _ = point.y //结果：100
        _ = point.0 //也可以采用类似数组的方式使用下标访问，结果：50
        _ = point.1 //结果：100
        
        //元组也可以不指定元素名称，访问的时候只能使用下标
        let frame:(Int,Int,Int,Float)=(0,0,100,100.0)
        print(frame) //结果：(0, 0, 100, 100.0)
        
        //注意下面的语句是错误的，如果指定了元组的类型则无法指定元素名称
        //let frame:(Int,Int,Int,Int)=(x:0,y:0,width:100,height:100)
        
        
        var size=(width:100,25) //仅仅给其中一个元素命名
        _ = size.width //结果：100
        _ = size.1 //结果：25
        
        
        var httpStatus:(Int,String)=(200,"success") //元组的元素类型并不一定相同
        
        var (status,description)=httpStatus //一次性赋值给多个变量，此时status=200，description="success"
        
        //接收元组的其中一个值忽略另一个值使用"_"(注意在Swift中很多情况下使用_忽略某个值或变量)
        var (sta,_)=httpStatus
        print("sta=\(sta)") //结果：sta=200
        
        /**
         * 元组作为函数的参数或返回值，借助元组实现了函数的多个返回值
         */
        func request()->(code:Int,description:String){
            return (404,"not found")
        }
        var result=request()
        _ = result.0 //结果：404
        _ = result.1 //结果：not found
        _ = result.code //结果：404
        _ = result.description //结果：not found
        
        
        // MARK: - 可选类型
        /*
         所谓可选类型就是一个变量或常量可能有值也可能没有值则设置为可选类型。在ObjC中如果一个对象类型没有赋值，则默认为nil，同时nil类型也只能作为对象类型的默认值，对于类似于Int等基本类型则对应0这样的默认值。由于Swift是强类型语言，如果在声明变量或常量时没有进行赋值，Swift并不会默认设置初值（这一点和其他高级语言不太一样，例如C#虽然也有可选类型，但是要求并没有那么严格）
         */
        
        var x:Float? //使用？声明成一个可选类型，如果不赋值默认为nil
        x=172.0
        
        var y:Float=60.0
        
        //var z=x+y //注意此句报错，因为Int和Int？根本就是两种不同的类型，在Swift中两种不同的类型不能运算（因为不会自动进行类型转化）
        var z=x!+y //使用！进行强制解包
        
        let age="29"
        var ageInt = Int(age)  //注意ageInt是Int可选类型而不是Int类型（因为String的toInt()方法并不能保证其一定能转化为Int类型）
        
        /*
         Swift中类似于Int和Int?并不是同一种类型，不能进行相关运算，如果要运算只能解包；
         可选类型其本质就是此类型内部存储分为“Some”和“None”两个部分，如果有值则存储到“Some”中，没有值则为“None”（早期Playground中可以看到两个部分，如今已经取消显示Some等描述了），使用感叹号强制解包的过程就是取出“Some”部分；
         既然可选类型有可能有值，也可能没有值那么往往有时候就需要判断。可以使用if直接判断一个可选类型是否为nil，这样一来就可以根据情况进行强制解包（从Some部分取出值的过程）；另一个选择就是在判断的同时如果有值则将值赋值给一个临时变量或常量，否则不进入此条件语句，这个过程称之为“可选绑定”
         */
        /*可选类型判断*/
        var ageT="29"
        var ageTInt = Int(ageT) //注意ageInt是Int可选类型而不是Int类型（因为String的toInt()方法并不能保证其一定能转化为Int类型）
        
        if ageTInt==nil {
            print("ageInt=nil")
        }else{
            print("ageInt=\(ageTInt!)") //注意这里使用感叹号!强制解析
        }
        
        /**
         * 可选类型绑定
         * 如果可选类型有值则将值赋值给一个临时变量或者常量（此时此变量或者常量接受的值已经不是可选类型），如果没有值则不执行此条件
         */
        if let newAgeT=ageTInt{ //此时newAge可以定义成常量也可以定义成变量
            print("newAge=\(newAgeT)") //注意这里并不需要对newAge强制解包
        }else{
            print("ageInt=nil")
        }
        
        
        /*
         通过演示可以看出Swift中的可选绑定如果实际计算不得不进行强制解包，如果一个可选类型从第一次赋值之后就能保证有值那么使用时就不必进行强制解包了，这种情况下可以使用隐式可选解析类型（通过感叹号声明而不是问号）
         */
        /*隐式解析可选类型
         */
        var age1:Int!=0 //通过感叹号声明隐式解析可选类型，此后使用时虽然是可选类型但是不用强制解包
        age1=29
        var newAge1:Int=age1 //不用强制解包直接赋值给Int类型（程序会自动解包）
        
        if var tempAge1=age1 {
            print("tempAge=\(tempAge1)")
        }else{
            print("age=nil")
        }
    }
}
