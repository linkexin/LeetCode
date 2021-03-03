// dp[i] 表示 到第 i 个元素为止且 i 元素选上了的最长子序列
// dp[i] = max{dp[j]} + 1，j < i && nums[j] < nums[i]
// 等于所有在 i 之前的且比 nums[i] 小的元素，这些元素的最长子序列的最大值 + 1
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count
        }
        var dp = Array(repeating: 1, count: nums.count)
        var maxLength = 0
        for i in 1 ..< nums.count {
            var tempMaxLength = 0
            for j in 0 ..< i  {
                if nums[j] < nums[i] {
                    tempMaxLength = max(tempMaxLength, dp[j])
                }
            }
            dp[i] = tempMaxLength + 1
            maxLength = max(maxLength, dp[i])
        }
        
        return maxLength
    }
}

let s = Solution()
print(s.lengthOfLIS([10,9,2,5,3,7,101,18])) //4
print(s.lengthOfLIS([1, 2])) //1
print(s.lengthOfLIS([4,10,4,3,8,9])) //3
