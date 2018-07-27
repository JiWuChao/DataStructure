
import Foundation

public struct Heap<T> {
    var elements : [T]
    let priorityFunction : (T, T) -> Bool //大堆还是小堆由外界处理
    
    
    /// 判空
    var isEmpty : Bool {
        return elements.isEmpty
    }
    
    /// 长度
    var count : Int {
        return elements.count
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
   public func pop() -> T? {
        return elements.first
    }
    
    
    /// 是否是根节点
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
   public func isRoot(_ index:Int) -> Bool {
        return index == 0
    }
    
    /// 左孩子的index
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
   public func leftChildIndex(of index:Int) -> Int {
        return (2 * index) + 1
    }
    
    /// 右孩子的index
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
   public func rightChildIndex(of index:Int) -> Int {
        return (2 * index) + 2
    }
    
    /// 父节点的Index
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
   public func parentIndex(of index: Int) -> Int {
        if index >= 1 {
            return (index - 1 ) / 2
        }
        return 0
    }
    
    
    /// 比较优先级
    ///
    /// - Parameters:
    ///   - firstIndex: <#firstIndex description#>
    ///   - secondIndex: <#secondIndex description#>
    /// - Returns: <#return value description#>
   public func isHigherPriority(at firstIndex:Int ,than secondIndex:Int) -> Bool {
        return priorityFunction(elements[firstIndex],elements[secondIndex])
    }
    
    /// 根据父节点和孩子结点的 index 比较出那个index所存储的值得优先级更高
    ///
    /// - Parameters:
    ///   - parentIndex: <#parentIndex description#>
    ///   - childIndex: <#childIndex description#>
    /// - Returns: <#return value description#>
   public func highestPriorityIndex(of parentIndex:Int ,and childIndex:Int) -> Int {
        
        guard childIndex < count && isHigherPriority(at:childIndex,than:parentIndex) else {
            //如果 childIndex >= count 或者 childIndex 的优先级 小于 parentIndex的优先级 则返回 childIndex
            return parentIndex
        }
        return childIndex
    }
    
    //传入一个父节点的index 返回 其和两个孩子结点的优先级最高的index
   public func highestPriorityIndex(for parent:Int) -> Int {
        return highestPriorityIndex(of:highestPriorityIndex(of:parent,and:leftChildIndex(of:parent)),and :rightChildIndex(of:parent))
    }
    
   public mutating func swapElement(at firstIndex:Int, with secondIndex:Int) {
        guard firstIndex != secondIndex else {
            // 如果 firstIndex == secondIndex 则跳过下面的代码 如果继续执行下去则swap方法会报错
            return
        }
        //        swap(&elements[firstIndex], &elements[secondIndex])
        elements.swapAt(firstIndex, secondIndex)
    }
    
    
    /// 入队
    ///
    /// - Parameter element: <#element description#>
   public mutating func enqueue(_ element: T) {
        elements.append(element)
        siftUp(elementAtIndex: count - 1)
    }
    
    /// 递归移动
    ///
    /// - Parameter index: <#index description#>
   public mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index) // 1
        guard !isRoot(index), // 2
            isHigherPriority(at: index, than: parent) // 3
            else { return }
        swapElement(at: index, with: parent) // 4
        siftUp(elementAtIndex: parent) // 5
    }
    
    /// 出队
    ///
    /// - Returns: <#return value description#>
   public mutating func dequeue() -> T? {
        guard !isEmpty // 1
            else { return nil }
        swapElement(at: 0, with: count - 1) // 2
        let element = elements.removeLast() // 3
        if !isEmpty { // 4
            siftDown(elementAtIndex: 0) // 5
        }
        return element // 6
    }
    
   public mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index) // 1
        if index == childIndex { // 2
            return
        }
        swapElement(at: index, with: childIndex) // 3
        siftDown(elementAtIndex: childIndex)
    }
    
    
   public init(elements: [T] = [], priorityFunction: @escaping (T, T) -> Bool) { // 1 // 2
        self.elements = elements
        self.priorityFunction = priorityFunction // 3
        buildHeap() // 4
    }
    
   public mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() { // 5
            siftDown(elementAtIndex: index) // 6
        }
    }
    
}
