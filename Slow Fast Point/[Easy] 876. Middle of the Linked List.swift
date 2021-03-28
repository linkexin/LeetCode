public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 利用快慢指针，快指针的步幅是慢指针的两倍，当h快指针到达链表尾部，慢指针正好在链表中间位置
class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        // 创建一个头结点，方便后面遍历
        let top: ListNode? = ListNode(0)
        top?.next = head
        var left = top, right = top
        while right != nil {
            left = left?.next
            right = right?.next?.next
        }
        return left
    }
}

let s = Solution()
let a = ListNode(1)
let b = ListNode(2)
let c = ListNode(3)
let d = ListNode(4)
let e = ListNode(5)
let f = ListNode(6)
a.next = b
b.next = c
c.next = d
d.next = e
e.next = f
print(s.middleNode(a)?.val)
print("done")
