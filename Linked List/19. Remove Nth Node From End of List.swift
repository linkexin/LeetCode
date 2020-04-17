public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var count = 0
        var copyList = head
        while copyList != nil {
            count += 1
            copyList = copyList?.next
        }
        
        if count < n || n <= 0 { return head }
        // remove first one
        if count - n - 1 < 0 { return head?.next }
        
        var newList = head
        // 因为上面已经对移除第一个元素做了特别判断，所以这里的 newHead 是不会被改变的
        let newHead = newList
        for i in 0...count - n - 1 {
            if i == count - n - 1 {
                newList?.next = newList?.next?.next
            } else {
                newList = newList?.next
            }
        }
        return newHead
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
var node = s.removeNthFromEnd(a, 2)
while node != nil {
    print(node!.val)
    node = node!.next ?? nil
}
