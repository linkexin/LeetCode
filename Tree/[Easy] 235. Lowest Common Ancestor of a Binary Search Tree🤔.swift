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

// 递归解法
class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        // 如果 p、q 都小于 root，那么只要遍历左子树
        if root?.val ?? 0 > p?.val ?? 0 && root?.val ?? 0 > q?.val ?? 0 {
            return lowestCommonAncestor(root?.left, p, q)
        }
        // 如果 p、q 都大于 root，那么只要遍历右子树
        if root?.val ?? 0 < q?.val ?? 0 && root?.val ?? 0 < p?.val ?? 0 {
            return lowestCommonAncestor(root?.right, p, q)
        }
        // 如果 p、q 一个在左一个在右，那么 root 就是两个节点的最小公共祖先
        return root
    }
}

// 非递归解法
class Solution1 {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var currentNode = root
        let pValue = p!.val
        let qValue = q!.val
        // 维护一个 currentNode，根据条件向左或者向右更新 currentNode
        while currentNode != nil {
            if currentNode!.val < pValue && currentNode!.val < qValue {
                currentNode = currentNode!.right
            } else if currentNode!.val > pValue && currentNode!.val > qValue {
                currentNode = currentNode!.left
            } else {
                return currentNode
            }
        }
        return nil
    }
}


let l1 = TreeNode(6)
let l2 = TreeNode(2)
l1.left = l2
let l3 = TreeNode(8)
l1.right = l3

let l4 = TreeNode(0)
l2.left = l4
let l5 = TreeNode(4)
l2.right = l5

let l6 = TreeNode(7)
l3.left = l6
let l7 = TreeNode(9)
l3.right = l7

let l8 = TreeNode(3)
l5.left = l8
let l9 = TreeNode(4)
l5.right = l9

let s = Solution()
let re = s.lowestCommonAncestor(l1, TreeNode(2), TreeNode(4))
print("done")
