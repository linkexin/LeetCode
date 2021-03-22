// 2021.03.22 滑动窗口，对应官方题解的第 3 种解法
// https://leetcode-cn.com/problems/minimum-size-subarray-sum/solution/chang-du-zui-xiao-de-zi-shu-zu-by-leetcode-solutio/
class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var start = 0, end = 0, sum = 0, minL = Int.max
        while start < nums.count && end < nums.count {
            sum += nums[end]
            while sum >= target {
                minL = min(minL, end - start + 1)
                sum -= nums[start]
                start += 1
            }
            end += 1
        }
        return minL == Int.max ? 0 : minL
    }
}

class Solution {
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        var left = 0, right = 0, minL = Int.max
        var sum = [[Int]]()
        while left <= right && right < nums.count {
            if right - 1 > left {
                sum[left][right] = sum[left][right - 1] + nums[right]
            } else {
                sum[left][right] = nums[right]
            }
            
            if sum[left][right] < s {
                right += 1
            } else {
                minL = min(minL, right - left)
                left += 1
            }
        }
        return minL
    }
}
