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
