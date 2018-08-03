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
        print("错了")
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        print("midIndex: \(midIndex)")
        if a[midIndex] > key {
            print(">")
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        } else if a[midIndex] < key {
            print("<")
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        } else {
            print("==")
            return midIndex
        }
    }
}
func binaryInsertSort<T:Comparable>(_ contents:inout [T]) -> [T] {
    for i in 1..<contents.count {
        print(contents[i])
       var location = binarySearch(contents, key: contents[i], range: Range.init(uncheckedBounds: (0,i+1)))
        guard let loc = location else { return contents }
       var temp = contents[loc]
        var j = i
        while j > loc  {
            contents[j] = contents[j-1]
            j -= 1
        }
        contents[loc] = temp
    }
    
    return contents
}

var arr = [1,33,0,2,4,44,3,5,66,7,9,10]

arr = binaryInsertSort(&arr)
//let idx = binarySearch(arr, key: 33, range: 0..<arr.count)
//print(idx)
print(arr)

extension Array {
    func insertionIndexOf(elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}

//var arr2 = [1,4,6,8,9,21]
//
//
//let index = arr2.insertionIndexOf(elem: 44) { (v1, v2) -> Bool in
//    return v1 < v2
//}
//print(index)
//
//print(arr2)
