public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 和 98 题一致
class Solution {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValid(root, Int.max, Int.min)
    }
    
    func isValid(_ root: TreeNode?, _ max: Int, _ min: Int) -> Bool {
        guard let root = root else {
            return true
        }
        if root.val >= max || root.val <= min {
            return false
        }
        return isValid(root.left, root.val, min) && isValid(root.right, max, root.val)
    }
}
