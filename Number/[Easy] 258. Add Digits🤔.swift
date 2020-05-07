// 我真的是不太喜欢数学题……因为不是靠努力想就能做出来的
// 常规解法：
class Solution {
    func addDigits(_ num: Int) -> Int {
        var n = num
        while n >= 10 {
            var temp = n, re = 0
            while temp > 0 {
                re += temp % 10
                temp /= 10
            }
            n = re
        }
        return n
    }
}

// 题解：https://leetcode-cn.com/problems/add-digits/solution/xiang-xi-tong-su-de-si-lu-fen-xi-duo-jie-fa-by-5-7/
// 证明：https://www.zhihu.com/question/30972581/answer/50203344
// 涉及到了数的「原根」概念
class Solution {
    func addDigits(_ num: Int) -> Int {
        return (num - 1) % 9 + 1
    }
}
