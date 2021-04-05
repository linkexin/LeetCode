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

// 这道题的时间复杂度应该是 o(n * m), n、m 分别为两个数的节点数
// 因为需要遍历所有的节点并且一一比较
class Solution {
    func checkSubTree(_ t1: TreeNode?, _ t2: TreeNode?) -> Bool {
        if t2 == nil {
            return true
        }
        if t1 == nil {
            return false
        }
        if t1?.val == t2?.val {
            return checkSubTree(t1?.left, t2?.left) && checkSubTree(t1?.right, t2?.right)
        } else {
            return checkSubTree(t1?.left, t2) || checkSubTree(t1?.right, t2)
        }
    }
}
