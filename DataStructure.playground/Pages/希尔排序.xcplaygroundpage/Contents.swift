//: [Previous](@previous)

import Foundation

//
func insertionSort<T:Comparable>(_ list: inout [T],sortBy:(T,T) -> Bool, start: Int, dk: Int) {
    for i in stride(from: (start + dk), to: list.count, by: dk) {
        let currentValue = list[i]
        var loc = i
        while loc >= dk && sortBy(list[loc - dk] ,currentValue){
            print("\(list[loc - dk]) 向后移动\(dk)位")
            list[loc] = list[loc - dk]
            loc -= dk
            print("list: \(list)")
        }
        list[loc] = currentValue
    }
}


func shellSort<T:Comparable>(_ contents: inout [T], sortBy:(T,T) -> Bool) {
    var sublistCount = contents.count / 2
    
    while sublistCount > 0 {
        print("---- dk= \(sublistCount) -----")
        for loc in 0..<sublistCount {
            print(" loc = \(loc)")
            insertionSort(&contents, sortBy: sortBy, start: loc, dk: sublistCount)
        }
        print("移动结果：\(contents)")
        sublistCount = sublistCount / 2
    }
    
}


var arr = [33,2,12,34,21]

print("原始数组是：\n\(arr)\n")
shellSort(&arr) { (v1, v2) -> Bool in
    return v1 > v2
}

print("最终结果：\n\(arr)\n")
