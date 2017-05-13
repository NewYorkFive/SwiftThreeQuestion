//
//  ViewController.swift
//  Question2
//
//  Created by NowOrNever on 13/05/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var resultMap:[[Int]] = [[Int]]();//所有结果集存放位置
    
    var map:DLMap = DLMap();//map
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //寻找结果
        findResultMap(availableNumber: map.availableNumber)
        //打印结果
        print("There are \(resultMap.count) results:")
        for i in 0..<resultMap.count {
            print("")
            printMap(map: resultMap[i])
        }
    }
    
    //寻找结果集
    func findResultMap(availableNumber:[Int]) {
        //当map中availableCount为零时，证明3*3格子已经填满，检查结果，当检查结果返回true时，将该结果加入结果集(resultMap)
        if map.availableCount == 0 {
            if checkMap() {
                resultMap.append(map.map)
            }
            return
        }
        
        //遍历map中可填元素，填一个，递归进入下次
        //这么递归填可以减少检查次数 由原本的9^9个变为 9！回
        // (9!) = 9*8*7*6*5*4*3*2*1
        for i in 0..<map.availableNumber.count {
            if map.availableNumber[i] == 0 {
                map.map.append(i + 1)   //当前map元素
                map.availableNumber[i] = 1; //标识当前位不可用
                findResultMap(availableNumber: map.availableNumber)
                map.availableNumber[i] = 0;
                map.map.removeLast()
            }
        }
        
    }
    
    //检查是否符合成立
    func checkMap() -> Bool{
        let sumOfLine = map.map[0] + map.map[3] + map.map[6];   //行和
        let sumOfRow = map.map[0] + map.map[3] + map.map[6];    //列和
        let sumOfDiagonal1 = map.map[0] + map.map[4] + map.map[8];  //左上至右下对角线
        let sumOfDiagonal2 = map.map[2] + map.map[4] + map.map[6];  //右上至左下对角线
        
        let result = sumOfLine == sumOfRow && sumOfLine == sumOfDiagonal1 && sumOfLine == sumOfDiagonal2;
        //当横竖斜行不相等 直接返回false
        if result == false {
            return false;
        }
        
        for i in 0..<3 {
            var tempLine = 0;
            var tempRow = 0;
            for j in 0..<3 {
                tempLine += map.map[i * 3 + j];
                tempRow += map.map[j * 3 + i];
            }
            if tempLine != sumOfLine {//只要有横行和不等于第一行和 直接返回false
                return false;
            }
            if tempRow != sumOfRow { //只要有列元素和不等于第一行和 直接返回false
                return false;
            }
        }
        
        return true;//全部通过，返回true
    }
    
    //打印map
    func printMap(map:[Int]){
        for i in 0..<3 {
            print(map[i * 3 + 0], map[i * 3 + 1], map[i * 3 + 2]);
        }
    }
}


class DLMap: NSObject {
    //填充的数字
    var map:[Int] = [Int]();
    //可用元素的标记，0为可用，1为不可用
    var availableNumber:[Int] = [0,0,0, 0,0,0, 0,0,0];
    //0标记元素的个数
    var availableCount:Int{
        get{
            var count:Int = 0
            for i in availableNumber {
                if i == 0 {
                    count += 1;
                }
            }
            return count
        }
    }
}
