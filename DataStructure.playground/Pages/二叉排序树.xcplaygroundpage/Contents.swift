//: [Previous](@previous)

import Foundation

//T: Comparable 传入的value 必须是可以比较的类型

public indirect enum BinaryTree<T: Comparable> {
    case empty
    case node(BinaryTree, T, BinaryTree)
    // 批量插入
    mutating func insertValues(values:[T]) {
        for value in values {
            insert(newValue: value)
        }
    }
    //插入
    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
    
    /*
        插入的步骤：
        1 从父节点结点开始判断 父节点是否为空 如果为空 返回一个左右子树都为空的结点 : 决定什么时候开始插入
        2 如果父节点不为空 判断父节点的value 和要插入的value的值得大小 : 决定插入左子树或者是右子树
            1) 新值 < 父节点的值 插入父节点的左子树 （然后递归 从第一步开始）
            2) 新值 > 父节点的值 插入父节点的右子树 （然后递归 从第一步开始）
    
        在查找其插入位置的过程中，逐渐完善各个节点的左子树或者右子树 （左子树和右子树有可能为空）
     
     */
    
    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
        
        switch self {
        case .empty:
            print(newValue)
            return .node(.empty, newValue, .empty)
        case let .node( left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            } else {
                print(value)
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
    
    
}


extension BinaryTree: CustomStringConvertible {
    public var description: String {
        var s = "x"
        switch self {
        case let .node(left, value, right):
            s += "x"
            return "\n value: \(value),\n \(s) left = [" + left.description + "],\n -\(s) right = [" + right.description + "]"
        case .empty:
            return ""
        }
    }
}


var tree = BinaryTree<Int>.empty
//    tree.insertValues(values: [7,4,9,10,3,5])
    tree.insert(newValue: 7)
    tree.insert(newValue: 4)
    tree.insert(newValue: 9)
    tree.insert(newValue: 10)
    tree.insert(newValue: 3)
    tree.insert(newValue: 5)

    print(tree)
