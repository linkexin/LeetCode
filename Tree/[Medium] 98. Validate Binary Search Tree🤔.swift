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

// faster than 75.56%
class Solution {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValid(root, Int.min, Int.max)
    }
    
    func isValid(_ root: TreeNode?, _ min: Int, _ max: Int) -> Bool {
        guard let r = root else {
            return true // 空树也是合法的二叉搜索树，返回 true
        }
        // 如果根结点比 min 还要小，或者比 max 还要大，直接判断不合法
        if r.val <= min {
            return false
        }
        if r.val >= max {
            return false
        }
        // 递归下去更新 min 或者 max 为当前结点的值，这样就可以保证后续子树也能是二叉搜索树
        return isValid(r.left, min, r.val) && isValid(r.right, r.val, max)
    }
}

let s = Solution()
let l1 = TreeNode(3)
let l2 = TreeNode(1)
let l3 = TreeNode(5)
let l4 = TreeNode(0)
let l5 = TreeNode(2)
let l6 = TreeNode(4)
let l7 = TreeNode(6)

l1.left = l2
l1.right = l3
l2.left = l4
l2.right = l5
l3.left = l6
l3.right = l7
print(s.isValidBST(l1))
