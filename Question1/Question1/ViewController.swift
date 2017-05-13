//
//  ViewController.swift
//  Question1
//
//  Created by NowOrNever on 13/05/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var disciples:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        traitorFind(number: 1)
    }

    //找叛徒（traitor）
    fileprivate func traitorFind(number:Int){
        print(disciples)
        
        var tempNumber = number;
        //仅有一个数的时候证明是traitor
        if disciples.count == 1 {
            print(disciples[0])
            return;
        }
        
        var index = 0;
        for _ in 0..<disciples.count {
            if tempNumber % 3 == 0  {
                tempNumber = 0; //到3清零
                disciples.remove(at: index) //移除元素
                index -= 1; //下标修正
            }
            tempNumber += 1;
            index += 1;
        }
        
        traitorFind(number: tempNumber)
    }


}


