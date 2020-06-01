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

// 递归
class Solution {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return recursion(root, root)
    }
    
    func recursion(_ n1: TreeNode?, _ n2: TreeNode?) -> Bool {
        if n1 == nil && n2 == nil {
            return true
        }
        if n1?.left?.val != n2?.right?.val {
            return false
        }
        
        if recursion(n1?.left, n2?.right) == false {
            return false
        } else {
            return recursion(n1?.right, n2?.left)
        }
    }
}
