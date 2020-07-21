public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 不改变指针，只改变结点内的 val
class Solution {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        var n1 = head
        var n2 = n1?.next
        
        while n1 != nil && n2 != nil {
            let temp = n1?.val ?? 0
            n1?.val = n2?.val ?? 0
            n2?.val = temp
            n1 = n2?.next
            n2 = n1?.next
        }
        return head
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
var node = s.swapPairs(a)
while node != nil {
    print(node!.val)
    node = node!.next ?? nil
}
