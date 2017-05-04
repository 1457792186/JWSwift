//
//  JWSwiftBaseViewController.swift
//  JSwiftTest
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 BP. All rights reserved.
//

import UIKit



// MARK: - 一·结构体
struct Caculator {
    func sum(a:Int,b:Int) -> Int {
        return a + b
    }
    
    @discardableResult
    func func1(a:Int,b:Int) ->Int {
        return a - b + 1
    }
}


// MARK: - 二·协议中的可选方法
@objc protocol MyProtocol {
    @objc optional func func1() //old: optional func func1()
    func func2()
}


// MARK: - 三·自定义类
// MARK: - 类扩展-------double转str
extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f" as NSString,self) as String
    }
}

/*
 作为一门面向对象语言，类当然是Swift中的一等类型。通过下面的例子让大家对Swift的class有一个简单的印象，在下面的例子中可以看到Swift中的属性、方法（包括构造方法和析构方法）
 */
// MARK: - 例1
//Swift中一个类可以不继承于任何其他基类，那么此类本身就是一个基类
class Person{
    //定义属性
    var name:String
    var height=0.0
    
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String){
        self.name=name
    }
    
    //定义方法
    func showMessage(){
        print("name=\(name),height=\(height)")
    }
    
    //析构方法，在对象被释放时调用,类似于ObjC的dealloc，注意此函数没有括号，没有参数，无法直接调用
    deinit{
        print("deinit...")
    }
    
}

//调用例1中的Person类
func namePerson(name:String) -> Bool {
    var p = Person(name: "Kenhin")
    p.height=172.0
    p.showMessage() //结果：name=Kenhin,height=172.0
    
    //类是引用类型
    var p2 = p
    p2.name = "Kaoru"
    print(p.name) //结果：Kaoru
    if p === p2 { //“===”表示等价于，这里不能使用等于“==”（等于用于比较值相等，p和p2是不同的值，只是指向的对象相同）
        print("p===p2") //p等价于p2,二者指向同一个对象
        
        return p === p2
    }
    return p === p2
}
/*
 从上面的例子不难看出：
 Swift中的类不必须继承一个基类（但是ObjC通常必须继承于NSObject），如果一个类没有继承于任何其他类则这个类也称为“基类”；
 Swift中的属性定义形式类似于其他语句中的成员变量（或称之为“实例变量”），尽管它有着成员变量没有的特性；
 Swift中如果开发者没有自己编写构造方法那么默认会提供一个无参数构造方法（否则不会自动生成构造方法）；
 Swift中的析构方法没有括号和参数，并且不支持自行调用；
 */

// MARK: - 例2
class MyNameClass{
    
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
    
    
    //例2调用例1中的Person类
    var p = Person(name: "Kenhin")
    func namePerson(name:String) -> Bool {
        p.height=172.0
        p.showMessage() //结果：name=Kenhin,height=172.0
        
        //类是引用类型
        var p2 = p
        p2.name = "Kaoru"
        print(p.name) //结果：Kaoru
        if p === p2 { //“===”表示等价于，这里不能使用等于“==”（等于用于比较值相等，p和p2是不同的值，只是指向的对象相同）
            print("p===p2") //p等价于p2,二者指向同一个对象
            
            return p === p2
        }
        return p === p2
    }
}

// MARK: - 属性
    /*
     Swift中的属性分为两种：存储属性（用于类、结构体）和计算属性（用于类、结构体、枚举），并且在Swift中并不强调成员变量的概念。 无论从概念上还是定义方式上来看存储属性更像其他语言中的成员变量，但是不同的是可以控制读写操作、通过属性监视器来属性的变化以及快速实现懒加载功能
     */
class Account {
    var balance:Double=0.0
}

class PersonWithProperty {
    //firstName、lastName、age是存储属性
    var firstName:String
    var lastName:String
    
    let age:Int
    
    //fullName是一个计算属性，并且由于只定义了get方法，所以是一个只读属性
    var fullName:String{
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
        //set方法中的newValue表示即将赋的新值，可以自己设置set中的newValue变量，如下：
        //        set(myValue){
        //        }
    }
    //如果fullName只有get则是一个只读属性，只读属性可以简写如下：
    //    var fullName:String{
    //        return firstName + "." + lastName
    //    }
    
    //属性的懒加载，第一次访问才会计算初始值，在Swift中懒加载的属性不一定就是对象类型，也可以是基本类型
    lazy var account = Account()
    
    
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(firstName:String,lastName:String,age:Int){
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
    }
    
    //定义方法
    func showMessage(){
        print("name=\(self.fullName)")
    }
}
//方法调用
func PersonWithPropertyAction() {
    var p=PersonWithProperty(firstName: "Kenshin", lastName: "Cui",age:29)
    p.fullName="Kaoru.Sun"
    p.account.balance=10
    p.showMessage()
}
/*
 计算属性并不直接存储一个值，而是提供getter来获取一个值，或者利用setter来间接设置其他属性；
 lazy属性必须有初始值，必须是变量不能是常量（因为常量在构造完成之前就已经确定了值）；
 在构造方法之前存储属性必须有值，无论是变量属性（var修饰）还是常量属性（let修饰）这个值既可以在属性创建时指定也可以在构造方法内指定
 
 上面的例子中不难区分存储属性和计算属性，计算属性通常会有一个setter、getter方法，如果要监视一个计算属性的变化在setter方法中即可办到（因为在setter方法中可以newValue或者自定义参数名），但是如果是存储属性就无法通过监视属性的变化过程了，因为在存储属性中是无法定义setter方法的。不过Swift为我们提供了另外两个方法来监视属性的变化那就是willSet和didSet，通常称之为“属性监视器”或“属性观察器”
 */
class AccountNew {
    //注意设置默认值0.0时监视器不会被调用
    var balance:Double=0.0{
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
}

class PersonNew {
    var firstName:String
    var lastName:String
    let age:Int
    
    var fullName:String{
        get{
            return firstName + "." + lastName
        }
        set{
            //对于计算属性可以直接在set方法中进行属性监视
            var array = ["hello","world"]
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
        }
    }
    lazy var account = AccountNew()
    init(firstName:String,lastName:String,age:Int){
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
    }
    
    //类型属性
    static var skin:Array<String>{
        return ["yellow","white","black"];
    }
    
}
//方法调用
func PersonNewWithPropertyAction() {
    var p=PersonNew(firstName: "Kenshin", lastName: "Cui",age:29)
    p.account.balance=1.0
    print("p.account.balance=\(p.account.balance)") //结果：p.account.balance=3.0
    for color in PersonNew.skin {
        print(color)
    }
}
/*
 和setter方法中的newValue一样，默认情况下载willSet和didSet中会有一个newValue和oldValue参数表示要设置的新值和已经被修改过的旧值（当然参数名同样可以自定义）；
 存储属性的默认值设置不会引起属性监视器的调用（另外在构造方法中赋值也不会引起属性监视器调用），只有在外部设置存储属性才会引起属性监视器调用；
 存储属性的属性监视器willSet、didSet内可以直接访问属性，但是在计算属性的get、set方法中不能直接访问计算属性，否则会引起循环调用；
 在didSet中可以修改属性的值，这个值将作为最终值（在willSet中无法修改）；
 */


// MARK: - 方法
/*
 方法就是与某个特定类关联的函数，其用法和前面介绍的函数并无二致，但是和ObjC相比，ObjC中的函数必须是C语言，而方法则必须是ObjC。此外其他语言中方法通常存在于类中，但是Swift中的方法除了在类中使用还可以在结构体、枚举中使用。关于普通的方法这里不做过多赘述，用法和前面的函数区别也不大，这里主要看一下构造方法
 */
class PersonAction {
    //定义属性
    var name:String
    var height:Double
    var age=0
    
    //指定构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String,height:Double,age:Int){
        self.name=name
        self.height=height
        self.age=age
    }
    
    //便利构造方法，通过调用指定构造方法、提供默认值来简化构造方法实现
    convenience init(name:String){
        self.init(name:name,height:0.0,age:0)
    }
    
    //实例方法
    func modifyInfoWithAge(age:Int,height:Double){
        self.age=age
        self.height=height
    }
    
    //类型方法
    class func showClassName(){
        print("Class name is \"Person\"")
    }
    
    //析构方法，在对象被释放时调用,类似于ObjC的dealloc，注意此函数没有括号，没有参数，无法直接调用
    deinit{
        print("deinit...")
    }
    
}
//通过便利构造方法创建对象
var p=PersonAction(name: "kenshin")
/*
 除构造方法、析构方法外的其他方法的参数默认除了第一个参数是局部参数，从第二个参数开始既是局部参数又是外部参数（这种方式和ObjC的调用方式很类似，当然，可以使用“#”将第一个参数同时声明为外部参数名，也可以使用“_”将其他参数设置为非外部参数名）。但是，对于函数，默认情况下只有默认参数既是局部参数又是外部参数，其他参数都是局部参数。
 构造方法的所有参数默认情况下既是外部参数又是局部参数；
 Swift中的构造方法分为“指定构造方法”和“便利构造方法（convenience）”，指定构造方法是主要的构造方法，负责初始化所有存储属性，而便利构造方法是辅助构造方法，它通过调用指定构造方法并指定默认值的方式来简化多个构造方法的定义，但是在一个类中至少有一个指定构造方法。
 */


// MARK: - 下标脚本
/*
 下标脚本是一种访问集合的快捷方式，例如：var a:[string],我们经常使用a[0]、a[1]这种方式访问a中的元素，0和1在这里就是一个索引，通过这种方式访问或者设置集合中的元素在Swift中称之为“下标脚本”（类似于C#中的索引器）。从定义形式上通过“subscript”关键字来定义一个下标脚本，很像方法的定义，但是在实现上通过getter、setter实现读写又类似于属性。假设用Record表示一条记录，其中有多列，下面示例中演示了如何使用下标脚本访问并设置某一列的值
 */
class Record {
    //定义属性，假设store是Record内部的存储结构
    var store:[String:String]
    
    init(data:[String:String]){
        self.store=data
    }
    
    //下标脚本（注意也可以实现只有getter的只读下标脚本）
    subscript(index:Int)->String{
        get{
            
            var key=self.store.keys.sorted()[index]
            return self.store[key]!
        }
        set{
            var key=self.store.keys.sorted()[index]
            self.store[key]=newValue //newValue参数名可以像属性一样重新自定义
        }
    }
    
    //下标脚本（重载）
    subscript(key:String)->String{
        get{
            return store[key]!
        }
        set{
            store[key]=newValue
        }
    }
}

func RecordAction() {
    var r=Record(data:["name":"kenshin","sex":"male"])
    print("r[0]=\(r[0])") //结果：r[0]=kenshin
    r["sex"]="female"
    print(r[1]) //结果：female
}




// MARK: - 继承
/*
 和ObjC一样，Swift也是单继承的（可以实现多个协议，此时协议放在后面），子类可以调用父类的属性、方法，重写父类的方法，添加属性监视器，甚至可以将只读属性重写成读写属性
 */
class Father {
    var firstName:String,lastName:String
    var age:Int=0
    var fullName:String{
        get{
            return firstName+" "+lastName
        }
    }
    
    init(firstName:String,lastName:String){
        self.firstName=firstName
        self.lastName=lastName
    }
    
    func showMessage(){
        print("name=\(fullName),age=\(age)")
    }
    
    //通过final声明，子类无法重写
    final func sayHello(){
        print("hello world.")
    }
}

class Student: Father {
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
        super.init(firstName: firstName, lastName: lastName)
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
/*
 在使用ObjC开发时init构造方法并不安全，首先无法保证init方法只调用一次，其次在init中不能访问属性。但是这些完全依靠文档约定，编译时并不能发现问题，出错检测是被动的。在Swift中构造方法(init)有了更为严格的规定：构造方法执行完之前必须保证所有存储属性都有值。这一点不仅在当前类中必须遵循，在整个继承关系中也必须保证，因此就有了如下的规定：
 
 子类的指定构造方法必须调用父类构造方法，并确保调用发生在子类存储属性初始化之后。而且指定构造方法不能调用同一个类中的其他指定构造方法；
 便利构造方法必须调用同一个类中的其他指定构造方法（可以是指定构造方法或者便利构造方法），不能直接调用父类构造方法（用以保证最终以指定构造方法结束）；
 如果父类仅有一个无参构造方法（不管是否包含便利构造方法），子类的构造方法默认就会自动调用父类的无参构造方法（这种情况下可以不用手动调用）；
 常量属性必须默认指定初始值或者在当前类的构造方法中初始化，不能在子类构造方法中初始化
 */



// MARK : - 协议
/*
 协议是对实例行为的一种约束，和ObjC类似，在Swift中可以定义属性和方法（ObjC中之所以能定义属性是因为@property的本质就是setter、getter方法）。和其他语言不同的是Swift中的协议不仅限于类的实现，它同样可以应用于枚举、结构体（如果只想将一个协议应用于类，可以在定义协议时在后面添加class关键字来限制其应用范围）
 */
protocol Named{
    //定义一个实例属性
    var name:String { get set }
    
    //定义一个类型属性
    static var className:String { get }
    
    //定义构造方法
    init(name:String)
    
    //定义一个实例方法
    func showName()
    
    //定义一个类型方法
    static func showClassName()
}

protocol Scored{
    var score:Double { get set }
}

//Person遵循了Named协议
class Person1:Named {
    //注意从Named协议中并不知道name是存储属性还是计算属性，这里将其作为存储属性实现
    var name:String
    
    var age:Int = 0
    
    static var className:String{
        return "Person"
    }
    
    //协议中规定的构造方法，必须使用required关键字声明，除非类使用final修饰
    required init(name:String){
        self.name=name
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

//Student继承于Person并且实现了Scored协议
class Student1: Person1,Scored {
    var score:Double=0.0
    
    init(name:String, score:Double){
        self.score = score
        super.init(name: name)
    }
    
    //由于上面自定义了构造方法则必须实现协议中规定的构造方法
    required init(name: String) {
        super.init(name: name)
    }
    
    func test(){
        print("\(self.name) is testing.")
    }
}

func testAction() {
    var p=Person1(name: "Kenshin Cui")
    p.showName() //结果：name=Kenshin Cui
    print("className=\(Person1.className)") //结果：className=Person
    Person1.showClassName() //结果：Class name is "Person"
    p.age=28
    
    var s:Named=Student1(name: "Kaoru",score:100.0) //尽管这里将s声明为Named类型，但是运行时仍然可以正确的解析（多态）,但是注意此时编译器并不知道s有test方法，所以此时调用test()会报错
    s.showName()
    
    //在下面的函数中要求参数stu必须实现两个协议
    func showMessage(stu:protocol<Named,Scored>){
        print("name=\(stu.name),score=\(stu.score)")
    }
    var s2=Student1(name: "Tom",score:99.0)
    showMessage(stu: s2) //结果:name=Tom,age=99.0
    
    
    //检测协议
    let b1 = s is Scored //判断p是否遵循了Scored协议
    if b1 {
        print("s has score property.")
    }
    //类型转化
    if let s3 = s as? Scored { //如果s转化成了Scored类型则返回实例，否则为nil
        print("s3' score is \(s3.score)") //结果：s3' score is 100.0
    }
    let s4 =  s as! Scored //强制转换，如果转化失败则报错
    print("s4' score is \(s4.score)") //结果：s4' score is 100.0
}
/*
 协议中虽然可以指定属性的读写，但即使协议中规定属性是只读的但在使用时也可以将其实现成可读写的；
 Swift的协议中可以约定属性是实例属性还是类型属性、是读写属性还是只读属性，但是不能约束其是存储属性还是计算属性;
 协议中的类型属性和类型方法使用static修饰而不是class（尽管对于类的实现中类型属性、类型方法使用class修饰）;
 协议中约定的方法支持可变参数，但是不支持默认参数;
 协议中约定的构造方法，在实现时如果不是final类则必须使用require修饰（以保证子类如果需要自定义构造方法则必须覆盖父类实现的协议构造方法，如果子类不需要自定义构造方法则不必）;
 一个协议可以继承于另外一个或多个协议，一个类只能继承于一个类但可以实现多个协议；
 协议本身就是一种类型，这也体现除了面向对象的多态特征，可以使用多个协议的合成来约束一个实例参数必须实现某几个协议；
 */



// MARK : -扩展
/*
 Swift中的扩展就类似于ObjC中的分类（事实上在其他高级语言中更多的称之为扩展而非分类），但是它要比分类强大的多，它不仅可以扩展类还可以扩展协议、枚举、结构体，另外扩展也不局限于扩展方法（实例方法或者类型方法），还可以扩展便利构造方法、计算属性、下标脚本
 */
class Person2 {
    var firstName:String,lastName:String
    var age:Int=0
    var fullName:String{
        get{
            return firstName+" "+lastName
        }
    }
    
    init(firstName:String,lastName:String){
        self.firstName=firstName
        self.lastName=lastName
    }
    
    func showMessage(){
        print("name=\(fullName),age=\(age)")
    }
}

extension Person2{
    
    //只能扩展便利构造方法，不能扩展指定构造方法
    convenience init(){
        self.init(firstName:"",lastName:"")
    }
    
    //只能扩展计算属性，无法扩展存储属性
    var personInfo:String{
        return "firstName=\(firstName),lastName=\(lastName),age=\(age)";
    }
    
    //扩展实例方法
    func sayHello(){
        print("hello world.")
    }
    
    //嵌套类型
    enum SkinColor{
        case Yellow,White,Black
    }
    
    //扩展类型方法
    static func skin()->[SkinColor]{
        return [.Yellow,.White,.Black]
    }
}

func testAction2() {
    var p=Person2()
    p.firstName="Kenshin"
    p.lastName="Cui"
    p.age=28
    print(p.personInfo) //结果：firstName=Kenshin,lastName=Cui,age=28
    p.sayHello() //结果：hello world.
    Person2.skin()
}


// MARK : - 枚举和结构体
// MARK : - 结构体
/*
 结构体和类是构造复杂数据类型时常用的构造体，在其他高级语言中结构体相比于类要简单的多（在结构体内部仅仅能定义一些简单成员），但是在Swift中结构体和类的关系要紧密的多，这也是为什么将结构体放到后面来说的原因。Swift中的结构体可以定义属性、方法、下标脚本、构造方法，支持扩展，可以实现协议等等，很多类可以实现的功能结构体都能实现，但是结构体和类有着本质区别：类是引用类型，结构体是值类型。
 */
struct Person3 {
    var firstName:String
    var lastName:String
    
    var fullName:String{
        return firstName + " " + lastName
    }
    
    var age:Int=0
    
    //构造函数，如果定义了构造方法则不会再自动生成默认构造函数
    //    init(firstName:String,lastName:String){
    //        self.firstName=firstName
    //        self.lastName=lastName
    //    }
    
    func showMessage(){
        print("firstName=\(firstName),lastName=\(lastName),age=\(age)")
    }
    
    //注意对于类中声明类型方法使用关键字class修饰，但结构体里使用static修饰
    static func showStructName(){
        print("Struct name is \"Person\"")
    }
}

func testAction3() {
    //注意所有结构体默认生成一个全员逐一构造函数,一旦自定义构造方法，这个默认构造方法将不会自动生成
    var p=Person3(firstName: "Kenshin", lastName: "Cui", age: 28)
    print(p.fullName) //结果：Kenshin Cui
    p.showMessage() //结果：firstName "Kenshin", lastName "Cui", age 28
    Person3.showStructName() //结果：Struct name is "Person"
    
    //由于结构体（包括枚举）是值类型所以赋值、参数传递时值会被拷贝(所以下面的实例中p2修改后p并未修改，但是如果是类则情况不同)
    var p2 = p
    p2.firstName = "Tom"
    print(p2.fullName) //结果：Tom Cui
    print(p.fullName) //结果：Kenshin Cui
}
/*
 默认情况下如果不自定义构造函数那么将自动生成一个无参构造函数和一个全员的逐一构造函数；
 由于结构体是值类型，所以它虽然有构造函数但是没有析构函数，内存释放系统自动管理不需要开发人员过多关注；
 类的类型方法使用class修饰（以便子类可以重写），而结构体、枚举的类型方法使用static修饰(补充：类方法也可以使用static修饰，但是不是类型方法而是静态方法；另外类的存储属性如果是类型属性使用static修饰，而类中的计算属性如果是类型属性使用class修饰以便可以被子类重写；换句话说class作为“类型范围作用域”来理解时只有在类中定义类型方法或者类型计算属性时使用，其他情况使用static修饰[包括结构体、枚举、协议和类型存储属性])；
 */


// MARK : -枚举
/*
 在其他语言中枚举本质就是一个整形，只是将这组相关的值组织起来并指定一个有意义的名称。但是在Swift中枚举不强调一个枚举成员必须对应一个整形值（当然如果有必要仍然可以指定），并且枚举类型的可以是整形、浮点型、字符、字符串。首先看一下枚举的基本使用
 */
//注意Swift中的枚举默认并没有对应的整形值，case用来定义一行新的成员，也可以将多个值定义到同一行使用逗号分隔，例如：case Spring,Summer,Autumn,Winter
enum Season{
    case Spring
    case Summer
    case Autumn
    case Winter
}

func testSwitch() {
    var s=Season.Spring
    
    //一旦确定了枚举类型，赋值时可以去掉类型实现简写
    s = .Summer
    
    switch s {
    case .Spring: //由于Swift的自动推断，这里仍然可以不指明类型
        print("spring")
    case .Summer:
        print("summer")
    case .Autumn:
        print("autumn")
    default:
        print("winter")
    }
}
/*
 事实上Swift中也可以指定一个值和枚举成员对应，就像其他语言一样（通常其他语言的枚举默认就是整形），但是Swift又不局限于整形，它可以是整形、浮点型、字符串、字符，但是原始值必须是一种固定类型而不能存储多个不同的类型，同时如果原始值为整形则会像其他语言一样默认会自动递增。
 */
//指定原始值(这里定义成了整形)
enum Season1:Int{
    case Spring=10 //其他值会默认递增,例如Summer默认为11，如果此处也不指定值会从0开始依次递增
    case Summer
    case Autumn
    case Winter
}

func testSwitch1()  {
    var summer=Season1.Summer
    
    //使用rawValue访问原始值
    print("summer=\(summer),rawValue=\(summer.rawValue)")
    
    //通过原始值创建枚举类型，但是注意它是一个可选类型
    var autumn=Season1(rawValue: 12)
    
    //可选类型绑定
    if let newAutumn=autumn{
        print("summer=\(newAutumn),rawValue=\(newAutumn.rawValue)")
    }
}

/*
 如果一个枚举类型能够和一些其他类型的数据一起存储起来往往会很有用，因为这可以让你存储枚举类型之外的信息（类似于其他语言中对象的tag属性，但是又多了灵活性），这在其他语言几乎是不可能实现的，但是在Swift中却可以做到，这在Swift中称为枚举类型相关值。要注意的是相关值并不是原始值，原始值需要事先存储并且只能是同一种类型，但是相关值只有创建一个基于枚举的变量或者常量时才会指定，并且类型可以不同（原始值更像其他语言的枚举类型）。 
 */
//相关值
enum Color{
    case RGB(String) //注意为了方便演示这里没有定义成三个Int类型（例如： RGB(Int,Int,Int)）而使用16进制字符串形式
    case CMYK(Float,Float,Float,Float)
    case HSB(Int,Int,Int)
}

func testSwitch3() {
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
}
/*
 上面提到其实枚举也有一些类型和结构体的特性，例如计算属性（包括类型属性，枚举只能定义计算属性不能定义存储属性，存储属性只能应用于类和结构体）、构造方法（其实上面使用原始值创建枚举的例子就是一个构造方法）、方法（实例方法、类型方法）、下标脚本 
 */
enum Season3:Int{
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

func testSwitch4() {
    var summer=Season3.Summer
    print(summer.tag) //结果：1
    print(Season3.enumName) //结果：Season
    Season3.showEnumName() //结果：Enum name is "Season"
    summer.showMessage() //结果：rowValue=1
    
    if let spring = Season3(prefix: "au") { //可选绑定，构造函数返回值可能为nil
        print(spring.tag) //结果：2
    }
}


// MARK : -泛型
/*
 泛型可以让你根据需求使用一种抽象类型来完成代码定义，在使用时才真正知道其具体类型。这样一来就好像在定义时使用一个占位符做一个模板，实际调用时再进行模板套用，所以在C++中也称为“模板”。泛型在Swift中被广泛应用，上面介绍的Array<>、Dictionary<>事实上都是泛型的应用。通过下面的例子简单看一下泛型参数和泛型类型的使用。
 */
/*泛型参数*/
//添加了约束条件的泛型（此时T必须实现Equatable协议）
func isEqual<T:Equatable>(a:T,b:T)->Bool{
    return a == b
}

protocol Stack1able{
    //声明一个关联类型
    associatedtype ItemType
    mutating func push(item:ItemType)
    mutating func pop()->ItemType;
}

struct Stack1:Stack1able{
    typealias ItemType = String

    var store:[ItemType]=[]
    
    mutating func push(item:ItemType){
        store.append(item)
    }
    
    mutating func pop()->ItemType{
        return store.removeLast()
    }
}


func tste()  {
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
    
    
    
    var s1 = Stack1()
    s1.push(item: "hello")
    s1.push(item: "world")
    let t1 = s1.pop()
    print("t1=\(t1)") //结果：t=world
}



class JWSwiftBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Swift"
// MARK: - 四·输出字符串
        /*
         Swift没有main函数，从top level code的上方开始往下执行（就是第一个非声明语句开始执行[表达式或者控制结构，类、结构体、枚举和方法等属于声明语句]），不能存在多个top level code文件(否则编译器无法确定执行入口，事实上swift隐含一个main函数，这个main函数会设置并调用全局 “C_ARGC C_ARGV”并调用由top level code构成的top_level_code()函数)；
         Swift通过import引入其他类库（和Java比较像）；
         Swift语句不需要双引号结尾（尽管加上也不报错），除非一行包含多条语句（和Python有点类似）
         */
        print("Hello, World!")
     
        
// MARK: - 五·3.0改变
        //Swift3.0对于可选类型控制更加严谨，隐式可选类型和其他类型的运算之后获得的是可选类型而不是隐式可选类型
        let a1:Int! = 1
        let b1 = a1 + 1 // 此时强制解包，b是Int型
        let c1 = a1 // 注意此时c是Int? 在之前的Swift版本中c是Int！
        
// MARK: - 命名
        // 1.去掉前缀
        let url1 = URL(string: "www.cmjstudio.com")
        let isFileURL = url1?.isFileURL //old:url1.fileURL ，现在更加注重语意
        let data1 = Data() //NSData
        
        // 2.方法名使用动词，其他名词、介词等作为参数或移除
        var array1 = [1,2,3]
        array1.append(contentsOf: [4,5,6]) // old:array1.appendContentsOf([4,5,6])
        array1.remove(at: 0) // old:array1.removeAtIndex(0)
        
        // 3.不引起歧义的情况下尽量消除重复
        let color1 = UIColor.red // old:var color1 = UIColor.redColor()
        
        // 4.枚举成员首字母变成小写
        let label1 = UILabel()
        label1.textAlignment = .center // old:label1.textAlignment = .Center
        
        // 5.按钮的Normal状态去掉
        let btn1 = UIButton()
        btn1.setTitle("hello", for: UIControlState()) // 相当于Normal状态
        
        
        
// MARK: - 去C风格
        let rect1 = CGRect(x: 0, y: 0, width: 100, height: 100)
        // 下面的代码将要报错，3.0完全废除这种类C的风格
        //let rect1 = CGRectMake(0, 0, 100, 100)
        
        if let context1 = UIGraphicsGetCurrentContext() {
            _ = CGContext.fillPath(context1) // old:CGContextFillPath(context1!)
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
        //let array1 = [1,2,3]
        let next = array1.index(after: 0)  // old:let start = array1.startIndex let next = start.successor()
        let first = array1.first { (element) -> Bool in // 增加新的方法
            element > 1
        }
        
        let r = Range(0..<3) //old: let _ = NSRange(location: 0, length: 3)
        
        // 下面的代码必须在控制器中执行，用于遍历当前view及其父视图
        for subview in sequence(first: self.view, next: { $0?.superview }){
            debugPrint(subview)
        }
        
        
        
// MARK: - 新的浮点协议
        let af = 2 * Float.pi // old: let a = 2 * M_PI
        let bf = 2.0 * .pi // 注意前面是浮点型，后面可以省略Float
        
        
// MARK: - 六·数据类型
        /*
         Swift通过var进行变量定义，通过let进行常量定义（这和其他高级语言比较类似，例如F#）；
         Swift添加了类型推断，对于赋值的常量或者变量会自动推断其具体类型；
         Swift是强类型语言（应该说它比C#、Java等强类型语言控制还要严格），不同的数据类型之间不能隐式转化，如果需要转化只能强制转化；
         在Swift中类型转换直接通过其类型构造函数即可，降低了API的学习成本；
         
         Swift包含了C和ObjC语言中的所有基础类型，Int整形，Float和Double浮点型，Bool布尔型，Character字符型，String字符串类型；当然还包括enum枚举、struct结构体构造类型；Array数组、Set集合、Dictionary字典集合类型；不仅如此还增加了高阶数据类型元组（Tuple），可选类型（Optinal）。
         */
        var a:Int = 1 //通过var定义一个变量
        
        var b = 2  //变量b虽然没有声明类型，但是会自动进行类型推断，这里b推断为Int类型
        
        var c:UInt=3
        let d = a+b //通过let定义一个变量
        
        
        //下面通过"\()"实现了字符串和变量相加(字符串插值)，等价于print("d="+String(d))
        print("d=\(d)") //结果：d=3
        //注意由于Swift是强类型语言，a是Int类型而c是UInt类型，二者不能运算，下面的语句报错;但是注意如果是类似于：let a=1+2.0是不会报错的，因为两个都是字面量，Swift会首先计算出结果再推断a的类型
        //let e=a+c
        
        //Int.max是Int类型的最大值，类似还有Int.min、Int32.max、Int32.min等
        let e = Int.max //结果：9223372036854775807
        
        var f:Float=1.0//浮点型
        var g=2.0 //浮点型自动推断为Double类型
        
        var h:String="hello "
        
        //emoj表情也可以作为变量或者常量，事实上所有Unicode字符都是可以的
        var 💖🍎="love and apple"
        
        //两个字符串相加，但是注意不同类型不能相加
        var i=h+💖🍎 //结果:hello love and apple
        
        //布尔类型只有两个值true、false，类似于if语句中的条件只能是布尔类型不能像ObjC一样非0即真
        var j:Bool=true
        
        //字符类型，同样使用双引号，但是只能是一个字符，如果不指定类型则"c"默认会推断为字符串（var k:Character="c"是字符类型，但是var k="c"是字符串类型）
        var k:Character="c"
        
        var l=00100 //等于100，可以在前面添加额外的0
        var m=10_000_000 //等于10000000，可以使用增加额外的下划线方便阅读而不改变值的大小
        
        
        //Int转换Float或Double：
        let intVar : Int = 3
        let doubleVar : Double = Double(intVar)
        //Int转换为String：
        let intVar1 : Int = 3
        let strVar1 : String = String(intVar1)
        //String转换为Int：
        let strVar2 : String = "123"
        let intVar2 : Int? = Int(strVar2)
        //Double转换为String：
        let doubleVar3 : Double = 3.14
        let strVar3 : String = String(doubleVar)
        //Double保留两位小数，需要对Double进行扩展：
//        extension Double {
//            func format(f: String) -> String {
//                return NSString(format: "%\(f)f", self)
//            }
//        }
        let myDouble = 1.234567
        print(myDouble.format(f: ".2"))
        //String转换Double：
        let strVar5 : String = "3.14"
        var string5 = NSString(string: strVar5).doubleValue
        
        
        
// MARK: - 七·集合类型
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
        
        
        
// MARK: - 八·运算符
        /*
         Swift中支持绝大多数C语言的运算符并改进以减少不必要的错误（例如等号赋值后不返回值），算术运算会检查溢出情况，必要时还能使用新增的溢出运算符。另外Swift中还可以对浮点数使用取余运算符，新增了区间运算符。对于基本的运算符这里不再一一介绍，简单看一下Swift中的区间运算符和溢出运算符
         */
        /**
         * 区间运算符,通常用于整形或者字符范围(例如"a"..."z"）
         */
        for i in 1...5 { //闭区间运算符...（从1到5，包含5）
            print("i=\(i)")
        }
        
        for i in 1..<5{ //半开区间运算符..<(从1到4)
            print("i=\(i)")
        }
        
        var strArr = "hello world."
        var range = "a"..."z"
//        for t in strArr {
//            if range.contains(String(t)) {
//                print(t) //结果：helloworld
//            }
//        }
        
        /*溢出运算符
         溢出运算符的原理其实很简单，例如对于UInt8，如果8位均为1则十进制表示是255，但是当加1之后则变成了9位“100000000”，出现了溢出但是UInt8本身值只能存储8位，所以取后面8位就变成了“00000000”，十进制表示就是0
         */
        var a_Max=UInt8.max //a=255
        //var b:UInt8=a+1 //注意b会出现溢出,此句报错
        
        //下面使用溢出运算符，结果为：0，类似的还有&-、&*、&/
        //使用溢出运算符可以在最大值和最小值之前循环而不会报错
        var b_Max:UInt8 = a_Max &+ 1
        
        
        
// MARK: - 九·控制流
        /*
         Swift中的多数控制流和其他语言差别并不大，例如for、while、do while、if、switch等，而且有些前面已经使用过（例如for in循环），这里将着重介绍一些不同点
         */
        var afor=["a","b","c","d","e","f","g"]
        let bfor=afor[1]
        /**
         *  switch支持一个case多个模式匹配，同时case后不用写break也会在匹配到种情况后自动跳出匹配，不存在隐式贯穿，如果想要贯穿在case之后添加"fallthrough"关键字
         */
        switch bfor{
        case "a","b":
            print("b=a or b=b")
        case "c","d","e","f":
            print("b in (c,d,e,f)")
        default:
            print("b=g")
        }
        
        /**
         * 匹配区间,同时注意switch必须匹配所有情况，否则必须加上default
         */
        
        let cfor:Int=88
        switch cfor{
        case 1...60:
            print("1-60")
        case 61...90:
            print("61-90")
        case 91...100:
            print("91-100")
        default:
            print("1>c>100")
        }
        
        /**
         *  元组匹配、值绑定、where条件匹配
         *  注意下面的匹配没有default，因为它包含了所有情况
         */
        var dfor=(x:900,y:0)
        switch dfor{
        case (0,0):
            print("d in (0,0)")
        case (_,0): //忽略x值匹配
            print("d in y")
        case (0,let y)://值绑定
            print("d in x,y=\(y)")
        case (-100...100,-100...100): //注意这里有可能和第一、二、三个条件重合，但是Swift允许多个case匹配同一个条件，但是只会执行第一个匹配
            print("x in（0-100），y in （0-100）")
        case let (x,y) where x==y: //where条件匹配,注意这里的写法等同于：(let x,let y) where x==y
            print("x=y=\(x)")
        case let (x, y):
            print("x=\(x),y=\(y)")
            
        }
        
        
        /*
         在其他语言中通常可以使用break、continue、return（Swift中添加了fallthrough）等来终止或者跳出某个执行语句，但是对于其行为往往是具有固定性的，例如break只能终止其所在的内层循环，而return只能跳出它所在的函数。在Swift中这种控制转移功能得到了加强，那就是使用标签。利用标签你可以随意指定转移的位置
         */
        var aBreak=5
        whileLoop:
            while aBreak > 0 {
                for i in 0 ..< aBreak{
                    print("a=\(aBreak),i=\(i)")
                    
                    break whileLoop
                    //如果此处直接使用break将跳出for循环，而由于这里使用标签直接跳出了while，结果只会打印一次，其结果为：a=4,i=0
                }
                aBreak -= 1
        }
        
        

        
        
// MARK: - 十·函数和闭包
// MARK: - 函数和闭包——结构体
        let ca = Caculator()
        ca.sum(a: 1, b: 2) // 此处会警告，因为方法有返回值但是没有接收
        let _ = ca.sum(a: 1, b: 2) // 使用"_"接收无用返回值
        ca.func1(a: 1, b: 2) // 由于func1添加了@discardableResult声明，即使不接收返回值也不会警告
// MARK: - 函数和闭包——函数
        /*函数是一个完成独立任务的代码块，Swift中的函数不仅可以像C语言中的函数一样作为函数的参数和返回值，而且还支持嵌套，并且有C#一样的函数参数默认值、可变参数等*/
        //定义一个函数，注意参数和返回值，如果没有返回值可以不写返回值或者写成Void、空元组()(注意Void的本质就是空元组)
        func sum(num1:Int,num2:Int)->Int{
            return num1 + num2
        }
        
        sum(num1: 1, num2: 2)
        /*
         Swift中的函数仅仅表达形式有所区别(定义形式类似于Javascript，但是js不用书写返回值)，但是本质并没有太大的区别。不过Swift中对函数参数强调两个概念就是局部参数名（又叫“形式参数”）和外部参数名，这极大的照顾到了ObjC开发者的开发体验。在上面的例子中调用sum函数并没有传递任何参数名，因为num1、num2仅仅作为局部参数名在函数内部使用，但是如果给函数指定一个外部参数名在调用时就必须指定参数名。另外前面也提到关于Swift中的默认参数、可变长度的参数，包括一些高级语言中的输入输出参数
         */
        /**
         *  函数参数名分为局部参数名和外部参数名
         */
        /**
         *  函数参数名分为局部参数名和外部参数名
         */
//        func split(string a:String,seperator b:Character)->[String]{
//            return split(a, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==b})
//        }
        
        //由于给split函数设置了外部参数名string和seperator，所以执行的时候必须带上外部参数名，此处可以看到一个有意义的外部参数名大大节省开发者使用成本
//        split(string: "hello,world,!", seperator: ",") //结果：["hello", "world", "!"]
        
        //下面通过在局部参数名前加上#来简写外部参数名（此时局部参数名和外部参数名相同）
//        func split2(#string:String,#seperator:Character)->[String]{
//            return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
//        }
//        split2(string: "hello,world,!", seperator: ",")
        
        //上面的split函数的最后一个参数默认设置为",",注意如果使用默认参数那么此参数名将默认作为外部参数名（此时局部参数名和外部参数名相同）
//        func split3(#string:String,seperator:Character=",")->[String]{
//            return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
//        }
//        split3(string: "hello,world,!", seperator: ",") //结果：["hello", "world", "!"]
//        split3(string: "hello world !", seperator: " ") //结果：["hello", "world", "!"]
        
        //但是如果有默认值，又不想指定局部参数名可以使用“_”取消外部参数名
//        func split4(string:String,_ seperator:Character=",")->[String]{
//            return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
//        }
//        split4("hello,world,!", ",") //结果：["hello", "world", "!"]
        
        /**
         * 可变参数,一个函数最多有一个可变参数并且作为最后一个参数
         * 下面strings参数在内部是一个[String]，对于外部是不定个数的String参数
         */
        func joinStr(seperator:Character=",",strings:String...)->String{
            var result:String=""
            for i in 0 ..< strings.count{
                if i != 0{
                    result.append(seperator)
                }
                result+=strings[i]
            }
            return result
        }
        
        joinStr(seperator:" ", strings: "hello","world","!") //结果："hello world !"
        
        /**
         * 函数参数默认是常量，不能直接修改，通过声明var可以将其转化为变量（但是注意C语言参数默认是变量）
         * 但是注意这个变量对于外部是无效的，函数执行完就消失了
         */
        func sum2( num1:Int,num2:Int)->Int{
            var num1 = num1
            num1 = num1 + num2
            return num1
        }
        
        sum2(num1: 1, num2: 2) //结果：3
        
        /**
         *  输入输出参数
         *  通过输入输出参数可以在函数内部修改函数外部的变量（注意调用时不能是常量或字面量）
         *  注意：下面的swap仅仅为了演示，实际使用时请用Swift的全局函数swap
         */
        func swap( a:inout Int , b:inout Int){
            a=a+b
            b=a-b
            a=a-b
        }
        
        var a233=1,b233=2
        swap(a: &a233, b: &b233) //调用时参数加上“&”符号
        print("a=\(a233),b=\(b233)") //结果："a=2,b=1"
 
        /*和很多语言一样，Swift中的函数本身也可以看做一种类型，既可以作为参数又可以作为返回值*/
        /**
         * 函数类型
         */
        var sum3=sum //自动推断sum3的类型：(Int,Int)->Int,注意不同的函数类型之间不能直接赋值
        sum3(1,2) //结果：3
        
        //函数作为返回值
        func fn()->(Int,Int)->Int{
            //下面的函数是一个嵌套函数，作用于是在fn函数内部
            func minus(a:Int,b:Int)->Int{
                return a-b
            }
            return minus;
        }
        var minus=fn()
        
        //函数作为参数
        func caculate(num1:Int,num2:Int,fn:(Int,Int)->Int)->Int{
            return fn(num1,num2)
        }
        
        caculate(num1: 1, num2: 2, fn: sum) //结果：3
        caculate(num1: 1,num2: 2, fn: minus) //结果：-1
        

// MARK: - 函数和闭包——闭包
        /*
         Swift中的闭包其实就是一个函数代码块，它和ObjC中的Block及C#、Java中的lambda是类似的。闭包的特点就是可以捕获和存储上下文中的常量或者变量的引用，即使这些常量或者变量在原作用域已经被销毁了在代码块中仍然可以使用。事实上前面的全局函数和嵌套函数也是一种闭包，对于全局函数它不会捕获任何常量或者变量，而对于嵌套函数则可以捕获其所在函数的常量或者变量。通常我们说的闭包更多的指的是闭包表达式，也就是没有函数名称的代码块，因此也称为匿名闭包
         在Swift中闭包表达式的定义形式如下：
         { ( parameters ) -> returnType in
         
         statements
         
         }
         */
        func sum1(num1:Int,num2:Int)->Int{
            return num1 + num2
        }
        
        func minus(num1:Int,num2:Int)->Int{
            return num1 - num2
        }
        
        func caculate1(num1:Int,num2:Int,fn:(Int,Int)->Int)->Int{
            return fn(num1,num2)
        }
        
        var (a11,b11)=(1,2)
        
        caculate1(num1: a, num2: b, fn: sum) //结果：3
        caculate1(num1: a, num2: b, fn: minus) //结果：-1
        
        //利用闭包表达式简化闭包函数
        caculate1(num1: a11, num2: b11, fn: {(num1:Int,num2:Int)->Int in
            return num1 - num2
        }) //结果：-1
        
        //简化形式,根据上下文推断类型并且对于单表达式闭包（只有一个语句）可以隐藏return关键字
        caculate1(num1: a11, num2: b11, fn: { num1,num2 in
            num1 - num2
        }) //结果：-1
        
        //再次简化，使用参数名缩写,使用$0...$n代表第n个参数，并且此in关键字也省略了
        caculate1(num1: a11, num2: b11, fn: {
            $0 - $1
        }) //结果：-1
        
        /*考虑到闭包表达式的可读取性，Swift中如果一个函数的最后一个参数是一个函数类型的参数（或者说是闭包表达式），则可以将此参数写在函数括号之后，这种闭包称之为“尾随闭包”*/
        func sum3(num1:Int,num2:Int)->Int{
            return num1 + num2
        }
        
        func minus2(num1:Int,num2:Int)->Int{
            return num1-num2
        }
        
        func caculate2(num1:Int,num2:Int,fn:(Int,Int)->Int)->Int{
            return fn(num1,num2)
        }
        
        var (a22,b22)=(1,2)
        
        //尾随闭包，最后一个参数是闭包表达式时可以卸载括号之后，同时注意如果这个函数只有一个闭包表达式参数时可以连通括号一块省略
        //请注意和函数定义进行区分
        caculate2(num1: a22, num2: b22){
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




