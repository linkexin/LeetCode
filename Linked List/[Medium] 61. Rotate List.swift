public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, k > 0 else {
            return head
        }
        
        var top = head
        var tail: ListNode?
        var count = 0
        // 1. get count and tailPoint of list
        while true {
            count += 1
            if top?.next == nil {
                tail = top
                break
            }
            top = top?.next
        }
        
        // 2. get the min count of rotate using modulo
        // 用取模的方式得到最小x旋转次数
        var n = k % count
        if n == 0 {
            return head
        }
        n = count - n
        
        // 3. already have top point and tail point
        //    we still need newTop point and newTail point
        // 3. 我们已经有 top、tail，还需要找到 newTop、newTail
        top = head
        var newTail: ListNode?
        var newTop: ListNode?
        var point = head
        for i in 1...n {
            if i == n {
                newTail = point
                newTop = newTail?.next
            } else {
                point = point?.next
            }
        }
        
        // 4. set newTail.next and tail.next, we done
        newTail?.next = nil
        tail?.next = top
        
        return newTop
    }
}



let s = Solution()
let a = ListNode(0)
let b = ListNode(1)
let c = ListNode(2)
let d = ListNode(4)
let e = ListNode(5)
let f = ListNode(6)
a.next = b
b.next = c
c.next = d
d.next = e
e.next = f
var node = s.rotateRight(a, -5)
while node != nil {
    print(node!.val)
    node = node!.next ?? nil
}
