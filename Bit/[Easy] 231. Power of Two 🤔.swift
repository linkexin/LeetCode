// 2 的次幂都是 100...000 的形式，也就是只有一个 1
class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        guard n > 0 else {
            return false
        }
        // 去掉最后一个 1 后是否等于 0
        return n & (n - 1) == 0
    }
}
