
/*
    1. 二叉树的深度 (递归，非递归)
    2. 翻转二叉树 (递归)
    3. 判断二叉树是否为平衡二叉树(两种) https://blog.csdn.net/K346K346/article/details/51085501
 */

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
//            print("&&&&&&&&&&&")
//            print("count : " + "\(queue.count)")
            let size = queue.count
//            for val in queue {
//                print(val.val)
//            }
//            print("*********")
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
    
    
     /// 翻转二叉树
     ///
     /// - Parameter root: <#root description#>
     /// - Returns: <#return value description#>
     public func invertTree(root:TreeNode<T>?) ->TreeNode<T>? {
        guard let rot = root else { return nil}
        rot.left = invertTree(root: rot.left)
        rot.right = invertTree(root: rot.right)
        print("before -- > rot.left :" + "\(String(describing: rot.left?.val))" + " " + "rot.right :" + "\(String(describing: rot.right?.val))" )
        let temp = rot.left
            rot.left = rot.right
            rot.right = temp
        
        print("after -- > rot.left :" + "\(String(describing: rot.left?.val))" + " " + "rot.right :" + "\(String(describing: rot.right?.val))" )
        return rot
    }
    
    
    /// 平衡二叉树
    
    /// 解法一
    
    /// 思路 ：根据二叉树的定义，我们可以递归遍历二叉树的每一个节点来，求出每个节点的左右子树的高度，如果每个节点的左右子树的高度相差不超过1，按照定义，它就是一颗平衡二叉树。
    
    /// 优点: 只要求出给定二叉树的高度，就可以方便的判断出二叉树是平衡二叉树，思路简单，代码简洁
    /// 缺点：由于每个节点都会被重复遍历多次，这造成时间效率不高。
    /// - Parameter node: <#node description#>
    /// - Returns: <#return value description#>
    public func isBalancedTree(node:TreeNode<T>?) -> Bool {
        guard let root = node else { return true }
        
        let leftDe = maxDepthNonRecursion(root: root.left)
        
        let rightDe = maxDepthNonRecursion(root: root.right)
        
        let diff = leftDe - rightDe
       // print("diff " + "\(diff)")
        if diff > 1 || diff < -1 {
            return false
        }
        return isBalancedTree(node: root.right) && isBalancedTree(node: root.left)
    }
    
    
    
    /// 平衡二叉树 解法二
    /// 思路: 在判断左右子树是否平衡的过程中把深度计算出来，这样在对父结点进行平衡判断时就可以不用再重复计算左右子树的深度了
    /// - Parameter node: <#node description#>
    /// - Returns: <#return value description#>
    public func isBalancedTree2(node:TreeNode<T>?) -> Bool {
        var depth = 0
        
        return isBalancedTreeOnce(rootNode: node, depth: &depth)
    }

    func isBalancedTreeOnce(rootNode:TreeNode?,depth:inout Int) -> Bool {
        guard let root = rootNode else {
            depth = 0
            return true
        }
        var leftDepth:Int = 0
        var rightDepth:Int = 0
        if isBalancedTreeOnce(rootNode: root.left, depth: &leftDepth) && isBalancedTreeOnce(rootNode: root.right, depth: &rightDepth) {
            
            let diff:Int = leftDepth - rightDepth
            
            if diff <= 1 && diff >= -1 {
                
                depth = leftDepth > rightDepth ? leftDepth + 1 : rightDepth + 1
                return true
            }
        }
        return false
    }
    
    
}

let node7 = TreeNode.init(left: nil, value: 7, right: nil)

let node6 = TreeNode.init(left: nil, value: 6, right: node7)

let node5 = TreeNode.init(left: nil, value: 5, right: nil)

let node4 = TreeNode.init(left: nil, value: 4, right: nil)

let node3 = TreeNode.init(left: node6, value: 3, right: nil)

let node2 = TreeNode.init(left: node4 , value: 2, right: node5)

let node1 = TreeNode.init(left: node2, value: 1, right: node3)

// 二叉树的深度 递归
print(node1.maxDepth(root: node1))

// 二叉树的深度 非递归
print(node1.maxDepthNonRecursion(root: node1))

print("翻转前")
print(node1.levelOrder(root: node1))
// 翻转二叉树
node1.invertTree(root: node1)

print("翻转后")

print(node1.levelOrder(root: node1))

// 平衡二叉树 一
print(node1.isBalancedTree(node: node1))


// 平衡二叉树 二

print(node1.isBalancedTree2(node: node1))
