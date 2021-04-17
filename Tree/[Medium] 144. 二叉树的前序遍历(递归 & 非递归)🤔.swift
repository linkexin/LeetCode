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

class Solution {
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        guard root != nil else {
            return []
        }
        var node = [Int]()
        node.append(root?.val ?? 0)
        node.append(contentsOf: preorderTraversal(root?.left))
        node.append(contentsOf: preorderTraversal(root?.right))
        return node
    }
}

// 不使用递归的解法，两种解法时间差不多，使用栈来维护节点
// 参考题解：https://leetcode-cn.com/problems/binary-tree-preorder-traversal/solution/leetcodesuan-fa-xiu-lian-dong-hua-yan-shi-xbian-2/
class Solution1 {
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        guard root != nil else {
            return []
        }
        var node = [Int]()
        var stack = [TreeNode]()
        stack.append(root ?? TreeNode())
        
        while stack.isEmpty == false {
            let top = stack.removeLast()
            node.append(top.val)
            // 注意先 append 右节点，再是左节点
            if top.right != nil {
                stack.append(top.right ?? TreeNode())
            }
            if top.left != nil {
                stack.append(top.left ?? TreeNode())
            }
        }
        
        return node
    }
}

let s = Solution()
let l1 = TreeNode(1)
let l2 = TreeNode(2)
let l3 = TreeNode(3)
let l4 = TreeNode(4)
let l5 = TreeNode(5)
let l6 = TreeNode(6)
l1.right = l2
l2.left = l3
l2.right = l4
l4.left = l5
l5.right = l6
print(s.preorderTraversal(l1))
