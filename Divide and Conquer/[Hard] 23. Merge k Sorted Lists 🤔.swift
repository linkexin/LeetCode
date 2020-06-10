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

// 分治法
// faster than 22.54%
class Solution1 {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        return recursion(lists, 0, lists.count - 1)
    }
    
    func recursion(_ list: [ListNode?], _ begin: Int, _ end: Int) -> ListNode? {
        guard begin <= end else {
            return nil
        }
        if begin == end {
            return list[begin]
        }
        let mid = (begin + end) / 2
        let l = recursion(list, begin, mid)
        let r = recursion(list, mid + 1, end)
        return mergeTwoLists(l, r)
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let head = ListNode()
        var p1 = l1, p2 = l2, tail: ListNode? = head
        while p1 != nil && p2 != nil {
            if (p1?.val) ?? 0 <= (p2?.val) ?? 0 {
                tail?.next = p1
                p1 = p1?.next
            } else {
                tail?.next = p2
                p2 = p2?.next
            }
            tail = tail?.next
        }
        if p1 != nil {
            tail?.next = p1
        }
        if p2 != nil {
            tail?.next = p2
        }
        return head.next
    }
}

