//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

public class SLNode<Int> {
    var value: Int
    var next :SLNode?// 下一个结点
    public init(value:Int) {
        self.value = value
    }
}

public final class SingleLinkList {
    
    public typealias Node = SLNode<Int>
    
    fileprivate var head:Node? // 头指针 指向首元结点
    
    public init() {}
    
    //1 是否为空
    func isEmpty() -> Bool {
        return head == nil
    }
    
    //2 获取首元结点
    public var first:Node?{
        return head
    }
    
    //3 获取尾结点
    public var last:Node? {
        if var node = head {
            while case let next? = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    //4 链表的长度
    public var count:Int {
        if var node = head {
            var c = 1
            while case let next? = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
    
    
    // 5 结点的获取
    
    func getNode(atIndex index:Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node?.next
            }
        }
        return nil
    }
    
    //找到在 index 之前的 node
    func getBeforeNode(atIndex index:Int) -> Node? {
        
        let tempIndex = index - 1
        
        if tempIndex >= 0 {
            var node = head
            var i = tempIndex
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node?.next
            }
        }
        return nil
    }
    
    
    
    // 链表的添加 按照顺序添加
    
    public func append(_ value: Int) {
        let newNode = SLNode(value: value)
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    // 批量添加 按照顺序添加
    public func append(_ values:Array<Int>) {
        for value in values {
            append(value)
        }
    }
    
    
    //5 链表的插入 插入在第 index 结点
    
    public func insertNode(atIndex index:Int,value:Int) {
        let oldNode = getBeforeNode(atIndex: index)
        let newNode = SLNode(value: value)
        if index > 0 {
            if let old = oldNode { // 插入
                /*
                    注意: 下面的两行的顺序不能换 这样的话整个链表就会出现死循环
                 old.next = newNode
                 newNode.next = old.next
                 */
                newNode.next = old.next
                old.next = newNode
            } else {
                append(value) // 插入到尾部
            }
        } else if (index == 0 ) {
            newNode.next = head // 插入到头部
            head = newNode
        } else {
            append(value)
        }
    }
    //删除在某一个 位置的结点
    public func removeNode(atIndex index:Int) {
        let beforeNode = getBeforeNode(atIndex: index)
        if let before = beforeNode {
            before.next = before.next?.next
        }
    }
    // 删除所有结点
    public func removeAll() {
        head = nil
    }
    
    
    
    /// 批量添加 生成有序链表
    ///
    /// - Parameter values: <#values description#>
    func insertValues(values:[Int]) {
        for value in values {
            insert(value: value)
        }
    }
    
    
    
    
    // 插入一个值 不指定位置 按 升序插入
    func insert(value: Int) {
        if self.head == nil { // 如果链表为空
            self.head = Node.init(value: value)
        } else {// 如果链表不为空 则从首元结点开始查找插入位置
            self.insert(node: &self.head!, value: value)
        }
    }
    
    
    /*
        思路：找到第一个比插入的值大的结点
        1 插入的值和当前结点的值做比较
        2 如果value 大于当前的结点值 则继续寻找一个比它大的值
        3 找到之后把插入的值放到比它大的值前面
        时间复杂度：O(n)
     */
    // inout 内部可以改变外面传的参数值
    func insert(node: inout Node, value: Int) {
        if value > node.value {
            if node.next == nil {
                node.next = Node.init(value: value)
            } else {
                self.insert(node: &node.next!, value: value)
            }
        } else {
            let newNode = Node.init(value: value)
            newNode.next = node // 头插法建立链表
            node = newNode
        }
    }
    
    /// 链表合并
    ///
    /// - Parameter list: <#list description#>
    func merge(list: SingleLinkList) {
        var listNode = list.head
        while listNode != nil {
            self.insert(value: listNode!.value)
            listNode = listNode!.next
        }
    }
    
}

extension SingleLinkList:CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node?.next
            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
}

var link = SingleLinkList.init()
    link.append([1,3,5,6,8,10])
//    link.insertNode(atIndex: 1, value: 11)
//    link.insertValues(values: [2,34,3,5,666,3,8,0])
    print(link)
var linkTow = SingleLinkList.init()
    linkTow.append([0,2,4,7,9,11])
    link.merge(list: linkTow)
    print(link)



