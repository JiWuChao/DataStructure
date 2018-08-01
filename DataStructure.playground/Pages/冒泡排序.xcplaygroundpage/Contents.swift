//: [Previous](@previous)
//:![image](https://github.com/JiWuChao/DataStructure/blob/master/DataStructure.playground/Pages/%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F.xcplaygroundpage/Resources/sort.png?raw=true)
import Foundation


/*
    使用泛型 需要外界传入是升序还是降序也就是 比较的规则 这样写的好处是
 这个排序方法任何容器中装的任何类型都可以使用 比如 Int ，String ,甚至是你自定义的 model 根据你model任意一个字段 作比较都是可以的
 
 */

/// 冒泡排序
///
/// - Parameters:
///   - contents: 要比较的内容
///   - sortBy: 排序规则
/// - Returns: 返回排好序的内容
func bubbleSort<T>(_ contents: inout [T],_ sortBy:(T,T)->Bool)->[T] {
    guard contents.count > 1 else {
        return contents
    }
    let n = contents.count
    for i in 0..<n {
        for j in 0..<(n - 1 - i) {
            if sortBy(contents[j],contents[j+1]){
                contents.swapAt(j, j + 1)
            }
        }
    }
    return contents
}


var nums = [11,3,27,8,9]
nums = bubbleSort(&nums, { (n1, n2) -> Bool in
    return n1 > n2
})

print(nums)

var strs = ["11","3","27","8","9"]
strs = bubbleSort(&strs, { (n1, n2) -> Bool in
    return n1.compare(n2) == .orderedAscending
})

print(strs)

