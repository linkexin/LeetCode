public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    // 自己尝试的方法，在最后两个 case 超时了
    // 思路就是类似穷举，快指针走 1 步 2 步 3 步，对应的慢指针走 1 步 2 步…… 这样一种一种 case 去试
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head?.next
        for i in 1 ... 10000 {
            if fast == nil {
                break
            }
            slow = head
            for _ in 0 ..< i {
                if fast === slow {
                    return fast
                }
                slow = slow?.next
            }
            fast = fast?.next
        }
        return nil
    }
}

class Solution {
    // 题解方法，主要还是在数学推导
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        while fast != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if slow === fast {
                var n1 = fast
                var n2 = head
                while n1 !== n2 {
                    n1 = n1?.next
                    n2 = n2?.next
                }
                return n1
            }
        }
        return nil
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
print(s.detectCycle(a))
print("done")
