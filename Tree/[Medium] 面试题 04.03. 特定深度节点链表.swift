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

class ListNode {
    var val: Int
    var next: ListNode? = nil
    init(_ value: Int) {
        self.val = value
    }
}

class Solution {
    func listOfDepth(_ tree: TreeNode?) -> [ListNode?] {
        var result = [ListNode]()
        dfs(tree, 0, &result)
        return result
    }
    
    func dfs(_ root: TreeNode?, _ level: Int, _ result: inout [ListNode]) {
        guard let root = root else {
            return
        }
        if result.count > level {
            // 生成新节点，然后插入链表头部
            let latest = ListNode(root.val)
            latest.next = result[level]
            result[level] = latest
        } else {
            result.append(ListNode(root.val))
        }
        // 注意这里先遍历右子树、再遍历左子树
        dfs(root.right, level + 1, &result)
        dfs(root.left, level + 1, &result)
    }
}
