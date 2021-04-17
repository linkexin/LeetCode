public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var order = [Int]()
        postorderTraversal(root, &order)
        return order
    }
    
    func postorderTraversal(_ root: TreeNode?, _ order: inout [Int]) {
        if root == nil {
            return
        }
        postorderTraversal(root?.left, &order)
        postorderTraversal(root?.right, &order)
        order.append(root!.val)
    }
}

// 非递归后续遍历 https://www.bilibili.com/video/BV15K4y1Y7Gz
// 前序是根左右，后续是左右根，所以前序->后序可以是
// 根左右->根右左->左右根
class Solution {
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var root = root
        var order = [Int]()
        var stack = [TreeNode?]()
        while root != nil || !stack.isEmpty {
            while root != nil {
                order.append(root!.val)
                stack.append(root)
                root = root?.right // 和前序不一样的地方，为了实现根右左，后序是尽可能的往右下走
            }
            let top = stack.removeLast()
            root = top?.left // 和前序不一样的地方
        }
        order = order.reversed() //根右左->左右根
        
        return order
    }
}

let s = Solution()
let l1 = TreeNode(1)
let l2 = TreeNode(2)
let l3 = TreeNode(3)
let l4 = TreeNode(4)
let l5 = TreeNode(5)
let l6 = TreeNode(6)
l1.right = l2
l2.left = l3
l2.right = l4
l4.left = l5
l5.right = l6
print(s.preorderTraversal(l1))
