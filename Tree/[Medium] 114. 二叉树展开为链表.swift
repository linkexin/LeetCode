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

// 首先，比较笨的办法，先把前序遍历的结果存下来，再按照 preorder 构造链表
// faster than 18.84%，less than 53.62%
class Solution {
    func flatten(_ root: TreeNode?) {
        var preorder = [Int]()
        preOrder(root, &preorder)
        var head: TreeNode?
        var current: TreeNode?
        for v in preorder {
            let node = TreeNode(v)
            current?.right = node
            current = node
            if head == nil {
                head = node
            }
        }
        root?.left = nil
        root?.right = head?.right
    }
    
    func preOrder(_ root: TreeNode?, _ order: inout [Int]) {
        if root == nil {
            return
        }
        order.append(root?.val ?? 0)
        preOrder(root?.left, &order)
        preOrder(root?.right, &order)
    }
}
