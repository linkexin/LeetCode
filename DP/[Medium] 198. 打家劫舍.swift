// 一遍过的 dp，只不过是 o(n^2) 的
// dp[i] 表示偷到第 i 家(一定包含第 i 家)可以得到的最大金额
// dp[i] = max{dp[j]} + nums[i], j: 0...i - 2
class Solution {
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var dp = Array(repeating: 0, count: nums.count)
        var result = nums[0]
        dp[0] = nums[0]
        for i in 1 ..< nums.count {
            if i - 2 < 0 {
                dp[i] = nums[i]
            } else {
                for j in 0 ... i - 2 {
                    dp[i] = max(dp[i], dp[j])
                }
                dp[i] += nums[i]
            }
            result = max(result, dp[i])
        }
        return result
    }
}
