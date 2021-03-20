// 把所有的值先存到数组中，再用双指针来判断，时间空间都不是很高效
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard head != nil else {
            return false
        }
        
        var arr = [Int]()
        var node = head
        while node != nil {
            arr.append(node!.val)
            node = node?.next
        }
        
        var a = 0, b = arr.count - 1
        while a < arr.count && b >= 0 && a != b {
            if arr[a] != arr[b] {
                return false
            }
            a += 1
            b -= 1
        }
        return true
    }
}

// 快慢指针，想要完全写对并不容易= =
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast = head, slow = head
        var pre: ListNode? = nil, cur = head, next = head?.next
        // 反转前半段链表
        // 注意这里的 while 判断
        while fast != nil && fast?.next != nil {
            // 先移动快慢指针
            fast = fast?.next?.next
            slow = slow?.next
            // 再反转节点
            cur?.next = pre
            pre = cur
            cur = next
            next = next?.next
        }
        
        // 奇数个节点，最终那一个不需要比较，slow 需要往后移一位
        if fast != nil {
            slow = slow?.next
        }
        
        // 前半段和后半段逐一比较
        // 注意这里用 slow 和 pre 两个指针一个个比较
        // 因为前半段已经反转了，所以 pre 顺着 next 指针一直往后，其实是从中间节点倒着往回走
        // 正好可以和 slow.next 对应上，感觉好妙
        while slow != nil {
            if pre?.val != slow?.val {
                return false
            }
            pre = pre?.next
            slow = slow?.next
        }
        return true
    }
}
