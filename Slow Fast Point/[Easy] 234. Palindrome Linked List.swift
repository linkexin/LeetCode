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
