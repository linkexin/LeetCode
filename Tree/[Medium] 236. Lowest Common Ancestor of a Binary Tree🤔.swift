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


// faster than 53.85%, less than 100.00%
// 递归，为了保证遍历到每一个节点，先递归左右子树，再判断
// 1. 如果左右子树有一个为 nil，那表示找到了一个目标节点或者是最终答案节点，return 非空的节点
// 2. 如果左右子树都不为 nil，那表示 root 本身就是答案，return root，在后续的递归中，左右子树递归的结果只有一个不为 nil，根据 1，这样就会一直 return 这个节点到栈空
class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return nil
        }
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        if left != nil && right != nil {
            return root
        }
        if root?.val == p?.val || root?.val == q?.val {
            return root
        }
        return left == nil ? right : left
    }
}

// faster than 73.83%
// 稍微改进了一点点，把「判断 p q 是否是 root」提前到递归之前，会更快一些
class Solution1 {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return nil
        }
        // 先判断 p q 是否是 root，如果是就直接返回，不用再递归下去了
        if root?.val == p?.val || root?.val == q?.val {
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left != nil && right != nil {
            return root
        }
        return left == nil ? right : left
    }
}

let l1 = TreeNode(3)
let l2 = TreeNode(5)
l1.left = l2
let l3 = TreeNode(1)
l1.right = l3

let l4 = TreeNode(6)
l2.left = l4
let l5 = TreeNode(2)
l2.right = l5

let l6 = TreeNode(0)
l3.left = l6
let l7 = TreeNode(8)
l3.right = l7

let l8 = TreeNode(7)
l5.left = l8
let l9 = TreeNode(4)
l5.right = l9

let s = Solution()
let re = s.lowestCommonAncestor(l1, TreeNode(6), TreeNode(7))
print("done")
