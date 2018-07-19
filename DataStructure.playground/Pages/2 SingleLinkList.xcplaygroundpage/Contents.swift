//: Playground - noun: a place where people can play

import UIKit
import Foundation

//------------------单向链表-------------------

public class SLNode<T> {
    var value: T
    var next :SLNode?// 下一个结点
    public init(value:T) {
        self.value = value
    }
}

public final class SingleLinkList<T> {
    
   public typealias Node = SLNode<T>
    
    fileprivate var head:Node?
    
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

    
    
    // 链表的添加
    
   public func append(_ value: T) {
        let newNode = SLNode(value: value)
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    // 批量添加
    public func append(_ values:Array<T>) {
        for value in values {
            append(value)
        }
    }
    
    
    //5 链表的插入 插入在第 index 结点
    
    public func insertNode(atIndex index:Int,value:T) {
        let oldNode = getBeforeNode(atIndex: index)
        let newNode = SLNode(value: value)
        if index > 0 {
            if let old = oldNode {
                newNode.next = old.next
                old.next = newNode
            } else {
                append(value)
            }
        } else if (index == 0 ) {
            newNode.next = head
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

    func reverseList(_ head: Node?) -> Node? {
        var head = head
        var next: Node? = head?.next
        var pre: Node? = nil
        while head != nil {
            head!.next = pre
            pre = head
            head = next
            next = head?.next
        }
        return pre
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
    
   public func solveHanoi(
        count: Int,
        from: String, to: String, other: String,
        move: (String, String) -> ()){
        if count > 0 {
            solveHanoi(count: count - 1, from: from, to: other, other: to, move: move)
            move(from, to)
            solveHanoi(count: count - 1, from: other, to: to, other: from, move: move)
        }
    }
    
    
}




let link = SingleLinkList<String>()
    link.isEmpty()
    link.append(["haha1","haha2","haha3","haha4","haha5"])
    print(link.getNode(atIndex: 0)?.value ?? "")
    link.insertNode(atIndex: 0, value: "插入")
    print(link)
    link.removeNode(atIndex: 1)
    print(link)
    print(link.count)
//    link.removeAll()
    print(link)

    print(link.head?.value)
    print(link.reverseList(link.head)?.value)
