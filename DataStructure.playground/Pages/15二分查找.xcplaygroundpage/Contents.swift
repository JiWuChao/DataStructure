//: [Previous](@previous)

import Foundation


/*
    线性搜索
    1 无论数组内的值有没有顺序 从第一个开始 逐个对比 直到找到key
    2 如果要找的key不在这个数组中 则会比对全部 O(n)
    缺点：比较次数太多，如果数组足够大，则效率会比较低
 
 */

/// 线性搜索
///
/// - Parameters:
///   - a: <#a description#>
///   - key: <#key description#>
/// - Returns: <#return value description#>
func linearSearch<T:Equatable> (_ a:[T], _ key:T) ->Int? {
    for i in 0..<a.count - 1 {
        if a[i] == key {
            return i
        }
    }
    return nil
}


let arr = [1,3,6,76,4,33,5,45,67,22,34,5465,656,99]

let index = linearSearch(arr, 67)
print(index!)


/*
    折半查找 数组要有序
    注意：折半查找在数组有序的时候才发挥最大作用
    1 把要数组分成两部分
    2 比较中间的值 如果要查找的key大于中间的值 则key在右边的区域反之在左边区域
    3 确定在左边或者右边之后 在左边/右边的部分在分成两部分 重复 2，3 直到找到key为止
 
 */



func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        } else {
            return midIndex
        }
    }
}

let arr2 = [1,2,3,4,5,6,7,8,9,10,11,23,44,55]

let index2 = binarySearch(arr2, key: 55, range: 0..<arr2.count)

print(index2!)

