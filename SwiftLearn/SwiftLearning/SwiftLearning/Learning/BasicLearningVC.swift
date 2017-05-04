//
//  BasicLearningVC.swift
//  JSwiftLearnMore
//
//  Created by apple on 17/3/8.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit

class BasicLearningVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Swift"
        
        // MARK: - 输出字符串
        /*
         Swift没有main函数，从top level code的上方开始往下执行（就是第一个非声明语句开始执行[表达式或者控制结构，类、结构体、枚举和方法等属于声明语句]），不能存在多个top level code文件(否则编译器无法确定执行入口，事实上swift隐含一个main函数，这个main函数会设置并调用全局 “C_ARGC C_ARGV”并调用由top level code构成的top_level_code()函数)；
         Swift通过import引入其他类库（和Java比较像）；
         Swift语句不需要双引号结尾（尽管加上也不报错），除非一行包含多条语句（和Python有点类似）
         */
        print("Hello, World!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
