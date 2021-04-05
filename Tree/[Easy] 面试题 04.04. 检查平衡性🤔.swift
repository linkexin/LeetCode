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

class Solution {
    func isBalanced(_ root: TreeNode?) -> Bool {
        let re = check(root)
        return re >= 0
    }
    
    func check(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let ld = check(root?.left)
        if ld == -1 {
            return -1
        }
        let rd = check(root?.right)
        if rd == -1 {
            return -1
        }
        if abs(ld - rd) > 1 {
            return -1
        }
        // 注意这里需要返回最大的深度
        return max(ld, rd) + 1
    }
}
