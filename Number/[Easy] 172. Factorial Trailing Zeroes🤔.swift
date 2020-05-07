// 看题目以为是个大数计算题，老老实实把阶乘算出来再数个数，妥妥超时
class Solution {
    func trailingZeroes(_ n: Int) -> Int {
        if n <= 1 {
            return 0
        }
        var result = [1]
        for i in 2 ... n {
            var flag = 0, temp = 0
            for j in 0 ... result.count - 1 {
                temp = result[j] * i + flag
                result[j] = temp % 10
                flag = temp / 10
            }
            while flag != 0 {
                result.append(flag % 10)
                flag /= 10
            }
        }
        for j in (0...result.count - 1).reversed() {
            print(result[j], terminator: "")
        }
        var count = 0
        while true {
            if result[count] == 0 {
                count += 1
            } else {
                break
            }
        }
        return count
    }
}

// 题解：https://leetcode-cn.com/problems/factorial-trailing-zeroes/solution/xiang-xi-tong-su-de-si-lu-fen-xi-by-windliang-3/
// 这个我自己是想不出来的
class Solution {
    func trailingZeroes(_ n: Int) -> Int {
        var num = n
        var count = 0
        while num > 0 {
            num /= 5
            count += num
        }
        return count
    }
}
