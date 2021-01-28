public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 参考：https://leetcode.com/problems/reverse-linked-list/discuss/58179/Swift-solution
class Solution {
    // 非递归方法
    func reverseList(_ head: ListNode?) -> ListNode? {
        var head = head
        var pre: ListNode? = nil
        var next: ListNode? = nil
        while head != nil {
            next = head?.next
            head?.next = pre
            pre = head
            head = next
        }
        return pre
    }
    
    // 递归方法
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let node = head else {
            return nil
        }
        if node.next == nil {
            return node
        }

        let newHead = reverseList(node.next)

        let nextNode = node.next
        nextNode?.next = node
        node.next = nil

        return newHead
    }
}

let s = Solution()
let a = ListNode(1)
let b = ListNode(2)
let c = ListNode(3)
let d = ListNode(4)
let e = ListNode(5)
a.next = b
b.next = c
c.next = d
d.next = e
var node = s.reverseList(nil)
while node != nil {
    print(node!.val)
    node = node!.next ?? nil
}
