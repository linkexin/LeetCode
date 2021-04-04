/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

// 官方题解已经说的和明白了 https://leetcode-cn.com/problems/house-robber-iii/solution/da-jia-jie-she-iii-by-leetcode-solution/
class Solution {
    func rob(_ root: TreeNode?) -> Int {
        let result = dfs(root)
        return max(result.selected, result.notSelected)
    }
    
    func dfs(_ root: TreeNode?) -> (selected: Int, notSelected: Int) {
        if root == nil {
            return (0, 0)
        }
        
        let left = dfs(root?.left)
        let right = dfs(root?.right)
        let selected = left.notSelected + right.notSelected + root!.val
        let noSelected = max(left.selected, left.notSelected) + max(right.selected, right.notSelected)
        return (selected, noSelected)
    }
}
