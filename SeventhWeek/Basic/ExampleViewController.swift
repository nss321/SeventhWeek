//
//  ExampleViewController.swift
//  SeventhWeek
//
//  Created by BAE on 2/4/25.
//

import UIKit

class User<T>{
    
    var myFuntion: (() -> Void)?
    
    var value: T {
        didSet {
            myFuntion
        }
    }
    
    init( _ value: T) {
        self.value = value
    }
}

class ExampleViewController: BaseViewController {
    
    let sean = User("Sean")
    
    var nickname = "션발롬ㅍㅇㅍㅇㅍㅇㅍㅇㅍㄴㅍㅇㄴ " {
        didSet {
            print(#function, nickname)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sean.myFuntion = {
            print(#function, self.sean.value)
        }
        test()
//        test2()
        nickname = "쓰@껄"
        sean.value = "배정훈"
        sean.value = "thegreatesteverbae"
    }
    
    func test() {
        var num = 3
        print(#function, num)
        
        num = 6
        print(#function, num)
    }
    
//    func test2() {
//        var num = Observable(3)
//        
//        num.bind { value in
//            print(value)
//        }
//        
//
//        num.value = 2
//        num.value = 100
//    }
}
