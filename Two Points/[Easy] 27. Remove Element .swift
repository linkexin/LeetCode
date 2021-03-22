class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        // 排序
        nums = nums.sorted()
        var left = 0, right = nums.count - 1, first = -1
        // 二分找到第一个val值
        while left <= right {
            let index = (left + right) / 2
            if nums[index] < val {
                left = index + 1
            } else if nums[index] > val {
                right = index - 1
            } else {
                first = index
                right = index - 1
            }
        }

        // remove val 值
        while first >= 0 && first < nums.count && nums[first] == val {
            nums.remove(at: first)
        }
        return nums.count
    }
    
    // 主要看双指针的解法
    // 因为「不需要考虑数组中超出新长度后面的元素」，也就是只看所返回长度的子数组是否和正确答案一致
    // 比如说 [0,1,2,2,3,0,4,2]，val = 2，返回结果是 5，那么 [0...5] 只要是 [0,1,3,0,4] 这几个数的组合即可，[0,1,3,0,4,3,4,2] 也是可以的
    // 所以不需要删除操作，直接=替换就好
    func removeElement2(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        var i = 0
        for j in 0 ... nums.count - 1 {
            if nums[j] != val {
                nums[i] = nums[j]
                i += 1
            }
        }
        return i
    }
}

let s = Solution()
var nums = [2]
print(s.removeElement(&nums, 2))
print(nums)
print("done")

// 2021.03.22 用最朴素的方法实现了一下，时间和空间效率都挺高的
class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        nums = nums.filter{ $0 != val }
        return nums.count
    }
}
