// A和B两个链表长度可能不同，但是A+B和B+A的长度是相同的，所以遍历A+B和遍历B+A一定是同时结束
// 如果A,B相交的话A和B有一段尾巴是相同的，所以两个遍历的指针一定会同时到达交点
// 如果A,B不相交的话两个指针就会同时到达A+B（B+A）的尾节点，再接下去就会同时变为 nil
class Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var p = headA
        var q = headB

        while q !== p {
            p = p == nil ? headB : p?.next
            q = q == nil ? headA : q?.next
        }
        return p
    }
}


let s = Solution()

let a1 = ListNode(4)
let a2 = ListNode(1)
let a3 = ListNode(8)
let a4 = ListNode(4)
let a5 = ListNode(5)
a1.next = a2
a2.next = a3
a3.next = a4
a4.next = a5

let b1 = ListNode(5)
let b2 = ListNode(0)
let b3 = ListNode(1)
let b4 = ListNode(8)
let b5 = ListNode(4)
let b6 = ListNode(5)
b1.next = b2
b2.next = b3
b3.next = a3
//        b4.next = b5
//        b5.next = b6

print(s.getIntersectionNode(a1, b1)?.value)
