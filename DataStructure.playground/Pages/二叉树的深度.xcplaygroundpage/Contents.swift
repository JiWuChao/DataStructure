//: [Previous](@previous)

public class TreeNode<T> {
    public var val: T
    public var left: TreeNode<T>?
    public var right: TreeNode<T>?
    public init(_val: T) {
        self.val = _val
    }
   public convenience init(left:TreeNode<T>?,value:T,right:TreeNode<T>?) {
        self.init(_val:value)
        self.left = left
        self.right = right
    }
    
    public func allTreeNodeCount(root:TreeNode?) -> Int {
 
        guard let ro = root else {
            return 0
        }
       return max(allTreeNodeCount(root: ro.left), allTreeNodeCount(root: ro.right)) + 1
 
    }
    
}

let node6 = TreeNode.init(left: nil, value: 6, right: nil)

let node5 = TreeNode.init(left: nil, value: 4, right: nil)

let node4 = TreeNode.init(left: nil, value: 4, right: nil)

let node3 = TreeNode.init(left: node6, value: 3, right: nil)

let node2 = TreeNode.init(left: node4 , value: 2, right: node5)

let node1 = TreeNode.init(left: node2, value: 1, right: node3)


print(node1.allTreeNodeCount(root: node1))
