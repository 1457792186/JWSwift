//
//  SwiftAdd.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class SwiftAdd: NSObject {
    func show() {
        //Swift3.0对于可选类型控制更加严谨，隐式可选类型和其他类型的运算之后获得的是可选类型而不是隐式可选类型
        let a:Int! = 1
        let b = a + 1 // 此时强制解包，b是Int型
        let c = a // 注意此时c是Int? 在之前的Swift版本中c是Int！
        
        // MARK: - 命名
        // 1.去掉前缀
        let url = URL(string: "www.cmjstudio.com")
        let isFileURL = url?.isFileURL //old:url.fileURL ，现在更加注重语意
        let data = Data() //NSData
        
        // 2.方法名使用动词，其他名词、介词等作为参数或移除
        var array = [1,2,3]
        array.append(contentsOf: [4,5,6]) // old:array.appendContentsOf([4,5,6])
        array.remove(at: 0) // old:array.removeAtIndex(0)
        
        // 3.不引起歧义的情况下尽量消除重复
        let color = UIColor.red // old:var color = UIColor.redColor()
        
        // 4.枚举成员首字母变成小写
        let label = UILabel()
        label.textAlignment = .center // old:label.textAlignment = .Center
        
        // 5.按钮的Normal状态去掉
        let btn = UIButton()
        btn.setTitle("hello", for: UIControlState()) // 相当于Normal状态
        
        
        
        // MARK: - 去C风格
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        // 下面的代码将要报错，3.0完全废除这种类C的风格
        //let rect = CGRectMake(0, 0, 100, 100)
        
        if let context = UIGraphicsGetCurrentContext() {
            _ = CGContext.fillPath(context) // old:CGContextFillPath(context1!)
        }
        
        // MARK: - GCD的改变
        let queue = DispatchQueue(label: "myqueue")
        queue.async {
            debugPrint("hello world!")
        }
        // old:
        //let queue = dispatch_queue_create("myqueue", nil)
        //dispatch_async(queue) {
        //    debugPrint("hello world!")
        //}
        
        // MARK: - 相关常量定义被移到枚举内部
        //        NotificationCenter.default.addObserver(self, selector: #selector(print()), name: UserDefaults.didChangeNotification, object: nil)
        //old:NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userDefaultChange()), name: NSUserDefaultsDidChangeNotification, object: nil)
        
        
        
        // MARK: - 集合API的变化
        //let array = [1,2,3]
        let next = array.index(after: 0)  // old:let start = array.startIndex let next = start.successor()
        let first = array.first { (element) -> Bool in // 增加新的方法
            element > 1
        }
        
        let r = Range(0..<3) //old: let _ = NSRange(location: 0, length: 3)
        
        // 下面的代码必须在控制器中执行，用于遍历当前view及其父视图
//        for subview in sequence(first: self.view, next: { $0?.superview }){
//            debugPrint(subview)
//        }
        
        
        
        // MARK: - 新的浮点协议
        let af = 2 * Float.pi // old: let a = 2 * M_PI
        let bf = 2.0 * .pi // 注意前面是浮点型，后面可以省略Float
    }
}
