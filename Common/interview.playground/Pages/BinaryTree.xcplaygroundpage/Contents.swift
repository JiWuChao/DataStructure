//: [Previous](@previous)

public struct Queue<T> {
    fileprivate var queueData = [T]()
    
    public var count:Int {
        return queueData.count
    }
    
    public var isEmpty : Bool {
        return queueData.isEmpty
    }
    
    public mutating func enqueue(elment:T) {
        queueData.append(elment)
    }
    
    public mutating func enqueueAll(elments:[T]) {
        for element in elments {
            queueData.append(element)
        }
    }
    
    
    
    public mutating func dequeue() ->T? {
        if !isEmpty {
           return queueData.remove(at: 0)
        }
        return nil
    }
    
    public var font:T {
        return queueData.first!
    }
    
}

extension Queue:CustomStringConvertible {
    public var description: String {
        var s = "["
        for (index,value) in queueData.enumerated() {
            s += "\(value)"
            if index != count - 1 {
                s += ","
            }
        }
        return s + "]"
    }
    
    
}


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
    
    /*
     定义：对任意一个子树的根节点来说，它的深度=左右子树深度的最大值+1
     
     （1）递归实现
     
     如果根节点为NULL，则深度为0
     
     如果根节点不为NULL，则深度=左右子树的深度的最大值+1
     
     
     */
    /// 树的深度: 在树中，节点的层次从根开始定义，根为第一层，树中节点的最大层次为树的深度。
    ///
    /// - Parameter root: <#root description#>
    /// - Returns: <#return value description#>
    public func maxDepth(root:TreeNode?) -> Int {
        
        guard let ro = root else {
            return 0
        }

        let left = maxDepth(root: ro.left)
        let right = maxDepth(root: ro.right)
        print("max:" + "\(max(left, right) + 1)" + " " + "root:" + "\(ro.val)")
        return max(left, right) + 1
        
    }
    
    
    /// 非递归实现:二叉树的层次遍历 遍历出的层数即为高度
    ///
    /// - Parameter root: <#root description#>
    /// - Returns: <#return value description#>
    public func maxDepthNonRecursion(root:TreeNode?) ->Int {
        guard let ro = root else { return 0 }
        
        let res = levelOrder(root: ro).count

        return res;
    }
    
    func levelOrder(root: TreeNode?) -> [[T]] {
        var res = [[T]]()
        // 用数组来实现队列
        var queue = [TreeNode]()
        
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            print("&&&&&&&&&&&")
            print("count : " + "\(queue.count)")
            let size = queue.count
            for val in queue {
                print(val.val)
            }
            print("*********")
            var level = [T]()
            
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(level)
        }
        
        return res
    }
    
    
    
    
}

let node7 = TreeNode.init(left: nil, value: 7, right: nil)

let node6 = TreeNode.init(left: nil, value: 6, right: node7)

let node5 = TreeNode.init(left: nil, value: 5, right: nil)

let node4 = TreeNode.init(left: nil, value: 4, right: nil)

let node3 = TreeNode.init(left: node6, value: 3, right: nil)

let node2 = TreeNode.init(left: node4 , value: 2, right: node5)

let node1 = TreeNode.init(left: node2, value: 1, right: node3)


print(node1.maxDepth(root: node1))


print(node1.maxDepthNonRecursion(root: node1))
