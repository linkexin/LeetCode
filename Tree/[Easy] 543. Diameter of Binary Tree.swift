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

// 思路为，将某个节点的左右子树的深度相加就是经过此节点的树的最大直径
// 遍历所有节点，取左右子树深度相加的最大值
class Solution {
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var max = Int.min
        _ = recursion(root, &max)
        return max
    }
    
    func recursion(_ root: TreeNode?, _ max: inout Int) -> Int {
        if root == nil {
            return 0
        }
        // 分别往下遍历左右子树的深度
        let leftD = recursion(root?.left, &max)
        let rightD = recursion(root?.right, &max)
        // 看看经过此节点的直径是否超过当前最大值
        if leftD + rightD > max {
            max = leftD + rightD
        }
        // 返回当前 root 节点的最大深度，记得 + 1
        return leftD > rightD ? leftD + 1 : rightD + 1
    }
}

let s = Solution()
let t1 = TreeNode(1)
let t2 = TreeNode(2)
let t3 = TreeNode(3)
let t4 = TreeNode(4)
let t5 = TreeNode(5)
let t6 = TreeNode(6)
let t7 = TreeNode(7)

t1.left = t2
t1.right = t3
t2.left = t4
t2.right = t5
t5.right = t6
t6.right = t7

print(s.diameterOfBinaryTree(t1))
