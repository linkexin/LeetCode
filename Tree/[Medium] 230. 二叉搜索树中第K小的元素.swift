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

// 中序遍历的变种题，只要搞清楚非递归的中序遍历怎么写，这题就很简单了
// 二叉搜索树按照中序遍历得到的数组是从小到大按顺序排列的
// 所以在中序遍历的过程中计数，数到第 k 个把结果记录下来返回即可
class Solution {
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var stack = [TreeNode]()
        var node = root
        var result = -1
        var count = 0
        while node != nil || !stack.isEmpty {
            while node != nil {
                stack.append(node!)
                node = node?.left
            }
            let top = stack.removeLast()
            // 记录目前已经遍历了几个节点
            count += 1
            if count == k {
                result = top.val
                break
            }
            node = top.right
        }
        return result
    }
}
