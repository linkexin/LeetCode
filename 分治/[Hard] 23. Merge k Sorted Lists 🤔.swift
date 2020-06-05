public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


// 把合并多个链表，分解为合并两个链表
// 但是时间比较慢 faster than 5.21%
// 时间复杂度 O(k^2 n)，空间复杂度 O(n)
class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var list: ListNode?
        for l in lists {
            list = mergeTwoLists(list, l)
        }
        return list
    }
    
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
