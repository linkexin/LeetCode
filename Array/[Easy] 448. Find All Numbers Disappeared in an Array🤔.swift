// O(n^2) 妥妥超时
class Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var result = [Int]()
        for i in 0 ..< nums.count {
            if !nums.contains(i + 1) {
                result.append(i + 1)
            }
        }
        return result
    }
}

// 两次循环，O(n) 时间复杂度，result 不算空间开销的话，O(1) 空间复杂度，这种解法的重点就是在 nums 上直接操作
class Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var nums = nums
        // 所有出现过的数字置为一个标记数字 -1
        for num in nums {
            nums[num - 1] = -1
        }
        // 找出不是 -1 的位置
        var result = [Int]()
        for (i, num) in nums.enumerated() {
            if num != -1 {
                result.append(i + 1)
            }
        }
        return result
    }
}
