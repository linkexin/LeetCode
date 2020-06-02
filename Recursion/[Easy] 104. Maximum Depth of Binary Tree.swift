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
// 递归求二叉树的深度，感觉只要是递归，空间复杂度就会高一些
class Solution {
    func maxDepth(_ root: TreeNode?) -> Int {
        guard root != nil else {
            return 0
        }
        let leftDepth = maxDepth(root?.left)
        let rightDepth = maxDepth(root?.right)
        return max(leftDepth + 1, rightDepth + 1)
    }
}
