public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    // 非递归方法
    func reverseList(_ head: ListNode?) -> ListNode? {
        var previous: ListNode? = nil
        var node = head
        var next = node?.next
        
        while true {
            next = node?.next
            node?.next = previous
            previous = node
            if next == nil {
                break
            }
            node = next
        }
        
        return node
    }
    
    // 递归方法
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let node = head else {
            return nil
        }
        if node.next == nil {
            return node
        }

        let newHead = reverseList(node.next)

        let nextNode = node.next
        nextNode?.next = node
        node.next = nil

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
var node = s.reverseList(nil)
while node != nil {
    print(node!.val)
    node = node!.next ?? nil
}
