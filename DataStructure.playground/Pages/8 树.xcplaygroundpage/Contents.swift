//: [Previous](@previous)

import Foundation
/*
    构造如下的树
 
            1
           /  \
          2      3
         /|\    |  \
        4 5 6   10   11
       /|\     / | \
      7 8 9   12 13 14
 */

/// 树的结点定义
public class TreeNode<T> {
    
    public var value:T
    
    public weak var parent:TreeNode? // 父节点 只有一个
 
    public var children = [TreeNode<T>]()// 有多个
    
    init(value:T) {
        self.value = value
    }
    
    public func addChild(_ node:TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
    
    
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
           s += " {" + children.map {
                $0.description
            }.joined(separator: ", ") + "}"
        }
        return s
    }
}


extension TreeNode where T:Equatable {
    //搜索
    public func search(_ value:T) ->TreeNode? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}


let one = TreeNode<String>.init(value: "1")

let tow = TreeNode<String>.init(value: "2")
let three = TreeNode<String>.init(value: "3")

let four = TreeNode<String>.init(value: "4")
let five = TreeNode<String>.init(value: "5")

let six = TreeNode<String>.init(value: "6")
let seven = TreeNode<String>.init(value: "7")

let eight = TreeNode<String>.init(value: "8")
let nine = TreeNode<String>.init(value: "9")
let ten = TreeNode<String>.init(value: "10")
let eleven = TreeNode<String>.init(value: "11")
let twelve = TreeNode<String>.init(value: "12")

let thirteen = TreeNode<String>.init(value: "13")
let fourteen = TreeNode<String>.init(value: "14")



one.addChild(tow)
one.addChild(three)

tow.addChild(four)
tow.addChild(five)
tow.addChild(six)

three.addChild(ten)
three.addChild(eleven)

four.addChild(seven)
four.addChild(eight)
four.addChild(nine)

ten.addChild(twelve)
ten.addChild(thirteen)
ten.addChild(fourteen)


print(one)

fourteen.parent

print(thirteen.parent?.parent)

