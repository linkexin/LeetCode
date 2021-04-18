class ListNode {
    var val: Int
    var next: ListNode? = nil
    init(_ value: Int) {
        self.val = value
    }
}

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

// 类似分治的方式
class Solution {
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        return sortedListToBST(head, nil)
    }
    
    func sortedListToBST(_ start: ListNode?, _ end: ListNode?) -> TreeNode? {
        // 最终条件判断
        if start === end {
            return nil
        }
        // 每次递归都通过快慢指针来找到中间节点
        var slow = start, fast = start
        while fast?.val != end?.val && fast?.next?.val != end?.val {
            slow = slow?.next
            fast = fast?.next?.next
        }
        let node = TreeNode(slow!.val)
        // 分成左右两边继续递归
        node.left = sortedListToBST(start, slow)
        node.right = sortedListToBST(slow?.next, end)
        return node
    }
}

let s = Solution()
// [-10, -3, 0, 5, 9]
let ln1 = ListNode(-10)
let ln2 = ListNode(-3)
let ln3 = ListNode(0)
let ln4 = ListNode(5)
let ln5 = ListNode(9)
ln1.next = ln2
ln2.next = ln3
ln3.next = ln4
ln4.next = ln5

let tree = s.sortedListToBST(ln1)
