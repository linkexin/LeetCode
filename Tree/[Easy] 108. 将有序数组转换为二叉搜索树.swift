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
        return sortedArrayToBST(nums, 0, nums.count - 1)
    }
    
    func sortedArrayToBST(_ nums: [Int], _ start: Int, _ end: Int) -> TreeNode? {
        if start > end {
            return nil
        }
        let mid = start + (end - start) >> 1
        let node = TreeNode(nums[mid])
        node.left = sortedArrayToBST(nums, start, mid - 1)
        node.right = sortedArrayToBST(nums, mid + 1, end)
        return node
    }
}
