class Solution {
    func hammingWeight(_ n: Int) -> Int {
        var n = n, result = 0
        while n != 0 {
            result += 1
            n = n & (n - 1) // 去掉最低一位的 1
        }
        return result
    }
}
