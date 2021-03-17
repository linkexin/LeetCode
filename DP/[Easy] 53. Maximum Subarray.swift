// faster than 98.86%，用 DP 一遍过了，有一点点点像最长上升子序列
// dp[i] 表示以i为结尾的子序列的最大和
// 既然第 i 个元素一定要包含在内，那么就看 dp[i - 1] + n[i] 和 n[i] 哪个更大

// 看题解发现这里的空间复杂度可以继续优化，可以在 nums 中直接做修改，不用创建 dp 数组
// 优化后空间复杂度为 o(1)
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        if nums.count == 1 {
            return nums[0]
        }
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        var maxSub = nums[0]
        
        for i in 1 ..< nums.count {
            dp[i] = max(dp[i - 1] + nums[i], nums[i])
            maxSub = max(maxSub, dp[i])
        }
        return maxSub
    }
}
