//: [Previous](@previous)

import Foundation

/// 折半查找 ：要求要查找的内容是有序的
///
/// - Parameters:
///   - contents:
///   - key: <#key description#>
///   - range: <#range description#>
/// - Returns: <#return value description#>
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


/*
    折半（二分）插入排序：
 
    直接插入排序相当于在已经排好序的数组部分逐个比较 找到合适的插入位置，在查找插入的位置时从第一个到最后一个，因为已经插入的内容是有序的，所有很多冗余的比较。即如果插入的比最后一个还大(还小)，则仍然会从第一个比较到最后一个
    折半插入排序是直接插入排序的优化版
    优化：
    由于直接插入排序是在查找插入位置的时候比较浪费时间，所以折半插入排序就优化查找。
 由于在逐渐插入的时候已经插入部分是有序的，查找插入位置其实就是在已经排好序的数组中找到一个位置，这时二分查找算法正好适合。
 
 
 
 */



/// 寻找要插入的位置
///
/// - Parameters:
///   - contents: <#contents description#>
///   - value: <#value description#>
///   - low: <#low description#>
///   - high: <#high description#>
/// - Returns: <#return value description#>
func binarySearchLocation<T:Comparable>(_ contents: inout [T],_ value:T ,_ low:Int,_ high:Int) ->Int {
    if high <= low {
        return (value > contents[low]) ? (low + 1): low
    }
    print("开始查找")
    let midIdx = low + (high - low ) / 2
    print("----当前已排好序的数组内容部分的中间位置是：第\(midIdx)个")
    if value == contents[midIdx] {
        return midIdx + 1
    }
    if value > contents[midIdx]{//binarySearchLocation(&contents, value, midIdx+1, high)
        print("-----从右边找")
        return binarySearchLocation(&contents, value, midIdx+1, high)
    }
    if value < contents[midIdx]{//binarySearchLocation(&contents, value, low, midIdx - 1)
        print("-----从左边找")
        return binarySearchLocation(&contents, value, low, midIdx - 1)
    }
    return 0
}



func binaryInsertSort<T:Comparable>(_ contents:inout [T]) -> [T] {
    var j = 0
    for i in 1..<contents.count {
        print("\n\n***********第\(i)次***********\n")
        j = i - 1
        let temp = contents[i] // 开始插入temp
        print("要插入的是\(temp)")//binarySearchLocation(&contents, temp, 0, j)
        let location = binarySearchLocation(&contents, temp, 0, j) //找到temp应该插入的位置
        print("-----找到了:第\(location)个合适")
        while j >= location  {
            print("--------第\(j)个向后移动到第\(j+1)个")
            contents[j+1] = contents[j]
            j -= 1
        }
        print("结果:\n+++++   把\(temp)放到第\(j+1)个位置  +++++")
        contents[j+1] = temp
        print("当前的排序结果是: \(contents[0...i])")
    }
    
    return contents
}

var arr = [1,33,0,2,4,44,3]

arr = binaryInsertSort(&arr)

print("\n--------最终结果是---------\n\(arr)")


