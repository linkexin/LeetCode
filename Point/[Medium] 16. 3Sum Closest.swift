// A 了 15 题以后这题就简单了
class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count <= 2 {
            return nums.reduce(0) { (res, num) -> Int in
                return res + num
            }
        }
        var nums = nums
        nums = nums.sorted()
        var closestSum = Int.max
        var closest = Int.max
        for i in 0...nums.count - 3 {
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            var left = i + 1, right = nums.count - 1
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                // 注意绝对值比较
                if abs(sum - target) < closest {
                    closest = abs(sum - target)
                    closestSum = sum
                }
                if sum < target {
                    repeat {
                        left += 1
                    // 重复的情况跳过，免得多算一遍
                    } while (left < right && nums[left] == nums[left - 1])
                } else {
                    repeat {
                        right -= 1
                    } while (left < right && nums[right] == nums[right + 1])
                }
            }
        }
        return closestSum
    }
}

let s = Solution()
s.threeSumClosest([0, 0, 0, 1], 5)
