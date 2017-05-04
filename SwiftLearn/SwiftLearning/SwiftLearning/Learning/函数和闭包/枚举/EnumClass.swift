//
//  EnumClass.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

/*
 在其他语言中枚举本质就是一个整形，只是将这组相关的值组织起来并指定一个有意义的名称。但是在Swift中枚举不强调一个枚举成员必须对应一个整形值（当然如果有必要仍然可以指定），并且枚举类型的可以是整形、浮点型、字符、字符串。首先看一下枚举的基本使用
 */
//注意Swift中的枚举默认并没有对应的整形值，case用来定义一行新的成员，也可以将多个值定义到同一行使用逗号分隔，例如：case Spring,Summer,Autumn,Winter
//1.基本型
enum Season{
    case Spring
    case Summer
    case Autumn
    case Winter
}

/*
 事实上Swift中也可以指定一个值和枚举成员对应，就像其他语言一样（通常其他语言的枚举默认就是整形），但是Swift又不局限于整形，它可以是整形、浮点型、字符串、字符，但是原始值必须是一种固定类型而不能存储多个不同的类型，同时如果原始值为整形则会像其他语言一样默认会自动递增。
 */


//2.指定原始值(这里定义成了整形)
enum SeasonWithOrigion:Int{
    case Spring=10 //其他值会默认递增,例如Summer默认为11，如果此处也不指定值会从0开始依次递增
    case Summer
    case Autumn
    case Winter
}
/*
 如果一个枚举类型能够和一些其他类型的数据一起存储起来往往会很有用，因为这可以让你存储枚举类型之外的信息（类似于其他语言中对象的tag属性，但是又多了灵活性），这在其他语言几乎是不可能实现的，但是在Swift中却可以做到，这在Swift中称为枚举类型相关值。要注意的是相关值并不是原始值，原始值需要事先存储并且只能是同一种类型，但是相关值只有创建一个基于枚举的变量或者常量时才会指定，并且类型可以不同（原始值更像其他语言的枚举类型）。
 */


//3.相关值
enum Color{
    case RGB(String) //注意为了方便演示这里没有定义成三个Int类型（例如： RGB(Int,Int,Int)）而使用16进制字符串形式
    case CMYK(Float,Float,Float,Float)
    case HSB(Int,Int,Int)
}

/*
 上面提到其实枚举也有一些类型和结构体的特性，例如计算属性（包括类型属性，枚举只能定义计算属性不能定义存储属性，存储属性只能应用于类和结构体）、构造方法（其实上面使用原始值创建枚举的例子就是一个构造方法）、方法（实例方法、类型方法）、下标脚本
 */
//4.带方法
enum SeasonWithFun:Int{
    case Spring=0 ,Summer,Autumn,Winter
    
    //定义计算属性
    var tag:Int{
        return self.rawValue
    }
    //类型属性
    static var enumName:String{
        return "Season"
    }
    
    //    //定义构造方法，注意在枚举的构造函数中则必须保证self有值（正如类的构造方法必须保证其存储属性有值一样）
    //    init(prefix:String){
    //        switch prefix.lowercaseString {
    //            case "sp":
    //                self = .Spring
    //            case "su":
    //                self = .Summer
    //            case "au":
    //                self = .Autumn
    //            default:
    //                self = .Winter
    //        }
    //    }
    //其实上面的构造器有些不合理，那就是default就是Winter，事实上这类构造器可能传任何参数，此时可以使用可失败构造函数来解决
    //可失败构造函数返回nil（尽管Swift中构造函数是不返回值的，但是此时约定返回nil代表构造失败）
    init?(prefix:String){
        switch prefix.lowercased() {
        case "sp":
            self = .Spring
        case "su":
            self = .Summer
        case "au":
            self = .Autumn
        case "wi":
            self = .Winter
        default:
            return nil
        }
    }
    
    //定义实例方法
    func showMessage(){
        print("rowValue=\(self.rawValue)")
    }
    //定义类型方法
    static func showEnumName(){
        print("Enum name is \"Season\"")
    }
}

class EnumClass: NSObject {

}
