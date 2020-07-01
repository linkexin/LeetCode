// faster than 88.54%
// dp[i] 表示从第 i 层楼梯走到终点有多少种可能，我的解法和有些解法是倒过来的，从 dp[n] 开始往前倒推，最后返回 dp[0]
class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        var dp = Array(repeating: 0, count: n)
        dp[n - 1] = 1
        dp[n - 2] = 2
        for i in (0 ..< n - 2).reversed() {
            dp[i] = dp[i + 1] + dp[i + 2]
        }
        return dp[0]
    }
}
