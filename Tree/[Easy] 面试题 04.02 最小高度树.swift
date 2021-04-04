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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return recursion(nums, 0, nums.count - 1)
    }
    
    func recursion(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        let mid = left + (right - left) >> 1
        let node = TreeNode(nums[mid])
        node.left = recursion(nums, left, mid - 1)
        node.right = recursion(nums, mid + 1, right)
        return node
    }
}
