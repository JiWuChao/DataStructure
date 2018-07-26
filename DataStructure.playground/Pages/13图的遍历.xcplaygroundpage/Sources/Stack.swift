import Foundation

public struct Stack<T> {
    
    fileprivate var stackData = [T]()
    
    //struct 的实例方法中默认不能修改属性值 如果要修改 需要加上 mutating 关键字
    // push
    public mutating func push(_ element: T) {
        stackData.append(element)
    }
    // 批量push
    public mutating func pushArray(_ elements:Array<T>) {
        for element in elements {
            push(element)
        }
    }
    
    // pop
    public mutating func pop() -> T? {
        return stackData.popLast()// popLast() 删除并返回数组中的最后一个值
    }
    //栈顶
    public var top: T? {
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

}


extension Stack:CustomStringConvertible {
    public var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        
        let stackElements = stackData.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}
