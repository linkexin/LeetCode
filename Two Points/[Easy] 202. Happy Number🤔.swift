// 题解中提到了数字有可能会无限增大的情况，思考的时候根本没有考虑这点，但实际上这种情况是不存在的不用考虑，具体可以看官方题解

// 1. 用 hash 表记录已经出现过的数字
class Solution {
    func isHappy(_ n: Int) -> Bool {
        var hash = [Int]()
        var num = n
        while num != 0 {
            if hash.contains(num) {
                return false
            }
            hash.append(num)
            var sum = 0
            var seperateNum = num
            while seperateNum != 0 {
                sum += (seperateNum % 10) * (seperateNum % 10)
                seperateNum /= 10
            }
            if sum == 1 {
                return true
            }
            num = sum
        }
        return false
    }
}

// 2. 使用查找链表中有没有环的方法，维护快慢两个指针，两个指针之间的步幅相差 1
class Solution {
    func calSum(_ s: Int) -> Int {
        var seperateNum = s
        var sum = 0
        while seperateNum != 0 {
            sum += (seperateNum % 10) * (seperateNum % 10)
            seperateNum /= 10
        }
        return sum
    }
    
    func isHappy(_ n: Int) -> Bool {
        var left = n, right = n
        while true {
            left = calSum(left)
            if left == 1 {
                return true
            }
            right = calSum(calSum(right))
            if right == 1 {
                return true
            }
            if left == right {
                return false
            }
        }
    }
}

let s = Solution()
s.isHappy(0)
