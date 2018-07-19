//: [Previous](@previous)

import Foundation

public indirect enum BinaryTree<T> {
    //左子树 值 右子树
    case node(BinaryTree<T>,T,BinaryTree<T>)
    case empty
    
    //计算结点数
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + right.count
        case .empty:
            return 0
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
        case .empty:
            return ""
        }
    }
}






