//: [Previous](@previous)

import Foundation

public struct Stack {
    
    fileprivate var stackData = [Int]()
    
    //struct 的实例方法中默认不能修改属性值 如果要修改 需要加上 mutating 关键字
    // push
    public mutating func push(_ element: Int) {
        stackData.append(element)
    }
    // 批量push
    public mutating func pushArray(_ elements:Array<Int>) {
        for element in elements {
            push(element)
        }
    }
    
    // pop
    public mutating func pop() -> Int? {
        return stackData.popLast()// popLast() 删除并返回数组中的最后一个值
    }
    
    public mutating func popAll() -> String? {
        var str = ""
        while count != 0 {
            str += "\(pop()!)"
        }
        return str
    }
    
    //栈顶
    public var top: Int? {
        return stackData.last //数组的最后一个值 及栈顶
    }
    
    //栈是否为空
    public var isEmpty: Bool {
        return stackData.isEmpty
    }
    
    // 栈的长度
    public var count: Int {
        return stackData.count
    }
    
    public mutating func tenTransformEight(value:Int) {
        var val = value
        while val > 0 {
            push(val % 8)
            val = val / 8
        }
    }
    
    
}





var stack = Stack.init()
    //1348 的 八进制 表示为 2504
    stack.tenTransformEight(value: 1348)

    print(stack.popAll() ?? "")



