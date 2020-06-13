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

// 递归解法
class Solution {
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        guard root != nil else {
            return []
        }
        var node = [Int]()
        node.append(contentsOf: postorderTraversal(root?.left))
        node.append(contentsOf: postorderTraversal(root?.right))
        node.append(root?.val ?? 0)
        return node
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
print(s.postorderTraversal(l1))
