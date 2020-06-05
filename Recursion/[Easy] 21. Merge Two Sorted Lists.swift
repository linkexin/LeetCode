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

// -------------------
// 非递归 O(1) 空间复杂度，直接改变现有的链表节点的 next，但是时间复杂度稍高一些
class Solution0 {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var list: ListNode?
        for l in lists {
            list = mergeTwoLists(list, l)
        }
        return list
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let head = ListNode() // 需要一个头部节点
        // p1 表示 l1 下一个需要合并的节点，p2 表示 l2 下一个需要合并的节点，tail 表示下一个插入位置的前一个位置
        var p1 = l1, p2 = l2, tail: ListNode? = head
        while p1 != nil && p2 != nil {
            if (p1?.val) ?? 0 <= (p2?.val) ?? 0 {
                tail?.next = p1
                p1 = p1?.next
                tail = tail?.next
            } else {
                tail?.next = p2
                p2 = p2?.next
                tail = tail?.next
            }
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
