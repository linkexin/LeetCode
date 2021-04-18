// 真的一开始题目看不懂… 迷之参数 pos
// 直接判断一个链表有没有环就行，不用管 pos
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
// 用题解说的 hash 的方式，结果超时了………
// 已经不是第一次遇到其他语言能过，swift 超时的情况了
extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return (lhs === rhs)
    }
}

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil {
            return false
        }
        var top = head
        var hash = [ListNode]()
        while top != nil {
            if hash.contains(top!) {
                return true
            }
            hash.append(top!)
            top = top?.next
        }
        return false
    }
}

// 快慢指针，如果存在环，快指针一定会套圈追上慢指针，但是两个指针的步伐要相差 1，不然可能会错过
class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil {
            return false
        }
        var slow = head
        var fast = head
        // 注意这个 while 条件，不是 slow != nil && fast != nil
        while slow?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                return true
            }
        }
        return false
    }
}

let s = Solution()
let a = ListNode(3)
let b = ListNode(2)
let c = ListNode(0)
let d = ListNode(-4)
//d.next = b
a.next = b
b.next = c
c.next = d
s.hasCycle(a)
