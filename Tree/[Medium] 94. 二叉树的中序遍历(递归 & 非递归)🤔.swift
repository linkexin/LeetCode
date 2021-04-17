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

// https://www.bilibili.com/video/BV15K4y1Y7Gz
class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var order = [Int]()
        var stack = [TreeNode?]()
        var root = root
        while root != nil || !stack.isEmpty {
            while root != nil {
                stack.append(root)
                root = root?.left
            }
            let top = stack.removeLast()
            order.append(top!.val) // 注意 order.append 在这里
            root = top?.right
        }
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
