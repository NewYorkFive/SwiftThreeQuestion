//
//  ViewController.swift
//  Question3
//
//  Created by NowOrNever on 13/05/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI(){
        //由于UInt32.max 为 4294967295 只能管理 9位数,这里十位数的生成算法就不写了
        //十位数的生成算法,也可以直接用DLLargeNumber中number数组直接添加十个随机小于10的整数，调用calculateProductWithDLLargeNumber方法即可
        //        print(UInt32.max)
        let largeNumber1:UInt32 = arc4random_uniform(1000000000);
        let largeNumber2:UInt32 = arc4random_uniform(1000000000);
        print("number1:")
        print(largeNumber1)
        print("number2:")
        print(largeNumber2)

        print("\nDetail:")
        let result = DLLargeNumber.calculateProductWithUInt32(number1: largeNumber1, number2: largeNumber2)
        print("\nfinal result:")
        print(result.number)
    }
}

class DLLargeNumber: NSObject {
    var number:[Int] = [Int]();
    
    
    /// 计算两个UInt32乘积
    class func calculateProductWithUInt32(number1:UInt32,number2:UInt32) -> DLLargeNumber{
        //number to largeNumber
        let largeNumber1 = numberToDLLargeNumber(number: number1)
        let largeNumber2 = numberToDLLargeNumber(number: number2)
//        print(largeNumber1.number)
//        print(largeNumber2.number)
        
        let sumOfLargeNumber = calculateProductWithDLLargeNumber(largeNumber1: largeNumber1, largeNumber2: largeNumber2)

        return sumOfLargeNumber;
    }
    
    // 两个大数相乘 return结果
    class func calculateProductWithDLLargeNumber(largeNumber1:DLLargeNumber,largeNumber2:DLLargeNumber) -> DLLargeNumber{
        var sumOfLargeNumber = DLLargeNumber()
        for i in 0..<largeNumber2.number.count {
            let oneStepResult:DLLargeNumber = largeNumberMultiplyANumber(largeNumber: largeNumber1, multiplier: largeNumber2.number[largeNumber2.number.count - i - 1])
            for _ in 0..<i {
                oneStepResult.number.append(0)
            }
            print("----")
            print(sumOfLargeNumber.number)
            print(oneStepResult.number)
            sumOfLargeNumber = largeNumberPlusLargeNumber(largeNumber1: sumOfLargeNumber, largeNumber2: oneStepResult)
            print(sumOfLargeNumber.number)
        }
        return sumOfLargeNumber;
    }

    //两个大数相加 return结果
    class func largeNumberPlusLargeNumber(largeNumber1:DLLargeNumber,largeNumber2:DLLargeNumber) -> DLLargeNumber{
        let targetNumber = DLLargeNumber()
        let maxCount = largeNumber1.number.count > largeNumber2.number.count ? largeNumber1.number.count : largeNumber2.number.count;
        var decimalNumber = 0;  //十位数
        for i in 0..<maxCount {
            var tempNumber = 0;
            if i < largeNumber1.number.count {
                tempNumber += largeNumber1.number[largeNumber1.number.count - i - 1];
            }
            if i < largeNumber2.number.count {
                tempNumber += largeNumber2.number[largeNumber2.number.count - i - 1];
            }
            tempNumber += decimalNumber;
            
            targetNumber.number.insert(tempNumber % 10, at: 0)
            
            decimalNumber = tempNumber / 10;
        }
        if decimalNumber != 0 {
            targetNumber.number.insert(decimalNumber, at: 0)
        }
        return targetNumber;
        
    }
    
    
    /// 大数乘以一个小于十的数
    /// - Returns: 结果
    class func largeNumberMultiplyANumber(largeNumber:DLLargeNumber,multiplier:Int) -> DLLargeNumber{
        let targetNumber = DLLargeNumber()
        var decimalNumber = 0;  //十位数
        for i in 0..<largeNumber.number.count {
            let tempNumber = largeNumber.number[largeNumber.number.count - i - 1] * multiplier + decimalNumber;
            targetNumber.number.insert(tempNumber % 10, at: 0)
            decimalNumber = tempNumber / 10;
        }
        
        if decimalNumber != 0 {
            targetNumber.number.insert(decimalNumber, at: 0)
        }
        
        return targetNumber;
    }
    
    //将数字转化DLLargeNumber对象，数字信息存在对象的数组里面，如“532”，存在对象(DLLargeNumber)数组number为[5,3,2]
    class func numberToDLLargeNumber(number:UInt32)->DLLargeNumber{
        let tempStringNumber = "\(number)"
        let stringNumber = NSString(string: tempStringNumber)
        let largeNumber:DLLargeNumber = DLLargeNumber()
        for i in 0..<stringNumber.length {
            let range = NSMakeRange(i, 1);
            let intChar = (stringNumber.substring(with: range));
            largeNumber.number.append(Int(intChar)!)
        }
        return largeNumber
    }

}

