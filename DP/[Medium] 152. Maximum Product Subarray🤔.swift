// dp[i][0]: [0...i] 这个范围内，其子数组的乘积最大值
// dp[i][1]: [0...i] 这个范围内，其子数组的乘积最小值
class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var dp = Array(repeating: Array(repeating: 0, count: 2), count: nums.count)
        var result = nums[0]
        dp[0][0] = nums[0]
        dp[0][1] = nums[0]
        
        for i in 1 ..< nums.count {
            if nums[i] >= 0 {
                // nums[i] 大于等于 0 的时候，乘上之前的最大值，才有可能是最大值，但是有可能之前的最大值是负数，所以还需要跟自己本身比较，因为子数组只有一个元素也是合法的
                // 同理，nums[i] 大于等于 0 的时候，乘上之前的最小值，才有可能是当前状态的最小值，但是之前的最小值有可能是正数，所以还需要和自己比较一下
                dp[i][0] = max(dp[i - 1][0] * nums[i], nums[i])
                dp[i][1] = min(dp[i - 1][1] * nums[i], nums[i])
            } else {
                // num[i] 小于 0 的时候，乘上之前的最小值，才有可能得到当前状态的最大值
                dp[i][0] = max(dp[i - 1][1] * nums[i], nums[i])
                dp[i][1] = min(dp[i - 1][0] * nums[i], nums[i])
            }
            result = max(result, dp[i][0])
        }
        
        return result
    }
