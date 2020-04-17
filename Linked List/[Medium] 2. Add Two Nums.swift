public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var ll1 = l1
        var ll2 = l2
        // 保证两个数的位数是一致的
        if l1 != nil && l2 == nil {
            ll2 = ListNode(0)
        }
        if l1 == nil && l2 != nil {
            ll1 = ListNode(0)
        }
        guard let a = ll1, let b = ll2 else {
            return nil
        }
        
        let curr = ListNode(a.val + b.val)
        if curr.val >= 10 {
            if a.next == nil {
                let next = ListNode(curr.val / 10)
                a.next = next
                curr.val %= 10
            } else {
                a.next?.val += 1
                curr.val %= 10
            }
        }
        // 递归调用
        curr.next = addTwoNumbers(a.next, b.next)
        return curr
    }
}

let s = Solution()
let a = ListNode(9)
let b = ListNode(4)
let c = ListNode(1)
a.next = b
b.next = c

let d = ListNode(9)
let e = ListNode(9)
let f = ListNode(8)
d.next = e
e.next = f
// 99 + 9， 99 + 1 这种 case 要注意
var re = s.addTwoNumbers(a, d)
while ((re) != nil) {
    print(re?.val)
    re = re?.next
}
