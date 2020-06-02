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

// 递归着把每个节点的左右子树交换一下
// faster than 95.38%, less than 100.00%
class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return nil
        }
        let temp = root?.left
        root?.left = invertTree(root?.right)
        root?.right = invertTree(temp)
        return root
    }
}

let s = Solution()
let l1 = TreeNode(4)
let l2 = TreeNode(2)
let l3 = TreeNode(7)
let l4 = TreeNode(1)
let l5 = TreeNode(3)
let l6 = TreeNode(6)
let l7 = TreeNode(9)

l1.left = l2
l1.right = l3

l2.left = l4
l2.right = l5

l3.left = l6
l3.right = l7
