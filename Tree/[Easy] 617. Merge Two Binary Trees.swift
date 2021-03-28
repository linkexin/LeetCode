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

// 把所有的修改都往 root1 上操作，最终返回 root1
// 当某个位置 root1 为 nil，就需要把 root2 的节点赋值给 root1，因此递归过程中需要把当前不为 nil 的节点返回给上一层，在上一层进行赋值操作
class Solution {
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil && root2 == nil {
            return nil
        }
        
        root1?.val += root2?.val ?? 0
        root1?.left = mergeTrees(root1?.left, root2?.left)
        root1?.right = mergeTrees(root1?.right, root2?.right)
        
        return root1 != nil ? root1 : root2
    }
}

let s = Solution()
let t11 = TreeNode(1)
let t12 = TreeNode(3)
let t13 = TreeNode(2)
let t14 = TreeNode(5)
let t15 = TreeNode(10)

let t21 = TreeNode(2)
let t22 = TreeNode(1)
let t23 = TreeNode(3)
let t24 = TreeNode(4)
let t25 = TreeNode(7)

t11.left = t12
t11.right = t13
t12.left = t14
t14.right = t15

t21.left = t22
t21.right = t23
t22.right = t24
t23.right = t25

let re = s.mergeTrees(t11, t21)
