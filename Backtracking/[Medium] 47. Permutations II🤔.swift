// faster than 45.69%
class Solution {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        // 先循环一遍记录每个数出现的频率
        var frequency = [Int: Int]()
        for n in nums {
            frequency[n, default: 0] += 1
        }
        
        var result = [[Int]](), current = Array(repeating: 0, count: nums.count)
        permutation(nums, 0, &frequency, &current, &result)
        return result
    }
    
    func permutation(_ nums: [Int], _ index: Int,_ freq: inout [Int: Int], _ cur: inout [Int], _ result: inout [[Int]]) {
        if index == nums.count {
            result.append(cur)
            return
        }
        
        // 注意这里不能遍历 nums，而是遍历 freq，因为 nums 中会有重复的数，遍历 nums 会在同一个位置放置同一个数字，最终会产生重复结果
        for n in freq.keys {
            if freq[n] ?? 0 > 0 {
                freq[n]! -= 1
                cur[index] = n
                permutation(nums, index + 1, &freq, &cur, &result)
                freq[n]! += 1
            }
        }
    }
}
