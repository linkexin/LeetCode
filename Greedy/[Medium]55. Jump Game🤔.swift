// 自己的解法，新开一个数组 step，step[i] true 或者 false 表示这个位置是否可以到达
// 边遍历边更新 step 数组，step[i] 为 true 时，把以 i 位置为起跳点，后续可以到达的位置都标记为 true
// 提交以后最后一个 case 超时了
class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var step = Array(repeating: false, count: nums.count)
        step[0] = true
        for i in 0 ..< step.count {
            if step[i] == false {
                continue
            }
            for j in 0 ... nums[i] {
                if i + j < step.count {
                    step[i + j] = true
                }
                // 如果已经到达最后，就直接返回结果
                if step.last == true {
                    return true
                }
            }
        }
        return step.last == true
    }
}


// 参考：https://leetcode-cn.com/problems/jump-game/solution/55-by-ikaruga/
// 这种方法所依据的核心思路：如果一个位置能够到达，那么这个位置左侧所有位置都能到达。
class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var k = 0 // 最远能跳到的位置
        for i in 0 ..< nums.count {
            // 目前的起跳点是 i，当之前最远能跳到的距离不能到达目前的起跳点，说明后续的点肯定也到不了
            if i > k {
                return false
            }
            // 如果最远能跳到的位置已经到达目的地了，直接 return，提高效率
            if k >= nums.count {
                return true
            }
            k = max(k, nums[i] + i)
        }
        return true
    }
}
