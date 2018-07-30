//: [Previous](@previous)

import Foundation

/*
 插入排序：
    此实现的算法与上文中所说有差异，是修改版的
    1：不需要一个辅助数组，节省内存空间
    2：不需要和前面的进行交换
 
    思路：
    1 从 数组中的第二个元素开始
    2 和第一个元素进行比较 如果满足排序条件sortBy:(T,T) -> Bool)
    3 则把第一个元素向后移一位 然后把第二个元素放在第一个位置上
    4 依此类推
 
    总结：此算法整个过程就是找一个合适的位置进行插入
 
 */

/// 插入排序
///
/// - Parameters:
///   - contents: 要排序的内容
///   - sortBy: 排序的条件
/// - Returns: <#return value description#>
func insertSort<T>(_ contents: [T], sortBy:(T,T) -> Bool) ->[T] {
    
    guard contents.count > 1 else {
        return contents
    }
    
    var cntnts = contents
    
    for i in 1..<cntnts.count { //从第二个元素开始 因为第一个元素是有序的
        var j = i
        let temp = cntnts[j]//保存当前的值
        while j > 0 && sortBy(temp,cntnts[j-1]) {//当前的值与其前一个值做比较
            cntnts[j] = cntnts[j-1] // 向后移动一位
            j -= 1
        }
        cntnts[j] = temp
    }
    return cntnts
}


var nums = [11,3,27,8,9]

nums = insertSort(nums, sortBy: { (n1, n2) -> Bool in
    return n1 < n2
})

print(nums)


var strs = ["11","3","27","8","9"]


strs = insertSort(strs, sortBy: { (s1, s2) -> Bool in
    return s1.compare(s2) == .orderedAscending
})


print(strs)

