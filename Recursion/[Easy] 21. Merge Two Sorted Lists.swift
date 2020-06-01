public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        let head = ListNode()
        var v: ListNode? = head
        while let v1 = l1?.val, let v2 = l2?.val {
            if v1 < v2 {
                v?.next = l1
                l1 = l1?.next
            } else {
                v?.next = l2
                l2 = l2?.next
            }
            v = v?.next
        }
        if l1 != nil {
            v?.next = l1
        }
        if l2 != nil {
            v?.next = l2
        }
        
        return head.next
    }
}

// -----------
// 递归方法
class Solution1 {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        if l1?.val ?? 0 < l2?.val ?? 0 {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
}

let s = Solution()
let l1 = ListNode(1)
let l2 = ListNode(2)
let l3 = ListNode(4)
let l4 = ListNode(5)
let l5 = ListNode(6)
let l6 = ListNode(7)
l1.next = l2
l2.next = l3
l4.next = l5
l5.next = l6
var re = s.mergeTwoLists(l4, l1)
while re != nil {
    print(re?.val)
    re = re?.next
}
