//: [Previous](@previous)

//https://www.raywenderlich.com/139821/swift-algorithm-club-swift-binary-search-tree-data-structure

import Foundation

/*
    indirect:
 
    Enumerations in Swift are value types. When Swift tries to allocate memory for value types, it needs to know exactly how much memory it needs to allocate.
 
    The enumeration you’ve defined is a recursive enum. That’s an enum that has an associated value that refers to itself. Recursive value types have a indeterminable size.
 
    So you’ve got a problem here. Swift expects to know exactly how big the enum is, but the recursive enum you’ve created doesn’t expose that information.
 
    Here’s where the indirect keyword comes in. indirect applies a layer of indirection between two value types. This introduces a thin layer of reference semantics to the value type.
 
    The enum now holds references to it’s associated values, rather than their value. References have a constant size, so you no longer have the previous problem.
 

 
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


// leaf nodes
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)

print(tree)



print(tree.count)









//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}
//let five = ArithmeticExpression.number(5)
//let four = ArithmeticExpression.number(4)
//let sum = ArithmeticExpression.addition(five, four)
//let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//
//
//func evaluate(_ expression: ArithmeticExpression) -> Int {
//    switch expression {
//    case let .number(value):
//        return value
//    case let .addition(left, right):
//        return evaluate(left) + evaluate(right)
//    case let .multiplication(left, right):
//        return evaluate(left) * evaluate(right)
//    }
//}




