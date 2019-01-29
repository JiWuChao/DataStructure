//: [Previous](@previous)

//https://www.raywenderlich.com/139821/swift-algorithm-club-swift-binary-search-tree-data-structure

import Foundation

/*
 
    递归枚举：是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
 

    indirect:
 
    Enumerations in Swift are value types. When Swift tries to allocate memory for value types, it needs to know exactly how much memory it needs to allocate.
    在 swift 中 枚举是值类型 当 给值类型申请内存是需要知道值类型需要多少内存
    The enumeration you’ve defined is a recursive enum. That’s an enum that has an associated value that refers to itself. Recursive value types have a indeterminable size.
 
    这个枚举是递归枚举类型。其成员是一个引用自身的关联值，没有确切的大小
 
    So you’ve got a problem here. Swift expects to know exactly how big the enum is, but the recursive enum you’ve created doesn’t expose that information.
    在 swift 需要知道申请的多少内存时，无法知道这个递归枚举类型需要多少内存
 
    Here’s where the indirect keyword comes in. indirect applies a layer of indirection between two value types. This introduces a thin layer of reference semantics to the value type.
 
    这就是间接关键字的来源。
 
    The enum now holds references to it’s associated values, rather than their value. References have a constant size, so you no longer have the previous problem.
    枚举持有关联类型的引用，引用的大小是一定的 这样在申请内存是就知道需要多少内存了
 

 
 */

public indirect enum BinaryTree<T> {
    //左子树 / 值 / 右子树
    case node(BinaryTree<T>,T,BinaryTree<T>)
    case empty
    
    //计算结点数
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count //递归
        case .empty:
            return 0
        }
    }
    
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        case .empty:
            return ""
        }
    }
}

//二叉树的遍历
extension BinaryTree {
    /*
     DLR—先序遍历，即先根再左再右
     LDR—中序遍历，即先左再根再右
     LRD—后序遍历，即先左再右再根
     */
    
    //先序遍历
    func traverseDLR(process:(T)->Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traverseDLR(process: process)
            right.traverseDLR(process: process)
        }
    }
    //中序遍历
    func traverseLDR(process:(T)->Void) {
        if case let .node(left, value, right) = self {
            left.traverseLDR(process: process)
            process(value)
            right.traverseLDR(process: process)
        }
    }
    // 后续遍历
    
    func traverseLRD(process:(T)->Void) {
        if case let .node(left, value, right) = self{
            left.traverseLRD(process: process)
            right.traverseLRD(process: process)
            process(value)
        }
    }
  
}

/*
         1
       /   \
      2     3
    /  \    /
    4   5  6
 */

//二叉树的构造过程
let node5 = BinaryTree.node(.empty, "5", .empty)
let node6 = BinaryTree.node(.empty, "6", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)

let node2 = BinaryTree.node(node4, "2", node5)
let node3 = BinaryTree.node(node6, "3", .empty)
let node1 = BinaryTree.node(node2, "1", node3)


print(node1)

print(node1.count)


print("\n\n\n")
print(" 先序遍历")
var s1 = ""
node1.traverseDLR { (value) in
    s1 += " -> " + "\(value)"
    print(s1)
}

print("\n\n\n")

print(" 中序遍历")
var s2 = ""
node1.traverseLDR { (value) in
    s2 += " -> " + "\(value)"
    print(s2)
}
print("\n\n\n")

print(" 后序遍历")
var s3 = ""
node1.traverseLRD { (value) in
    s3 += " -> " + "\(value)"
    print(s3)
}
print("\n\n\n")






