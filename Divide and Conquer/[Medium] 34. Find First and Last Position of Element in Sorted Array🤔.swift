// 二分区间，然后分别查找子区间的 target 范围，如果左右区间都存在 target，再将左右区间合并一下
// faster than 17.98%
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        return recursion(nums, target, 0, nums.count - 1)
    }
    
    func recursion(_ nums: [Int], _ target: Int, _ begin: Int, _ end: Int) -> [Int] {
        if begin > end {
            return [-1, -1]
        }
        if begin == end {
            return nums[begin] == target ? [begin, begin] : [-1, -1]
        }
        if nums[begin] == target && nums[end] == target {
            return [begin, end]
        }
        let mid = (begin + end) / 2
        var left = [-1, -1], right = [-1, -1]
        // target 在左区间范围内，就递归查找
        if !(nums[begin] > target || nums[mid] < target) {
            left = recursion(nums, target, begin, mid)
        }
        // target 在右区间范围内，就递归查找
        if !(nums[mid + 1] > target || nums[end] < target) {
            right = recursion(nums, target, mid + 1, end)
        }
        // 合并左右区间
        if left[1] + 1 == right[0] {
            return [left[0], right[1]]
        }
        return left == [-1, -1] ? right : left
    }
}

// 2020.02.07
class Solution {
    // 全局变量用来更新左右边界值
    var left = Int.max, right = Int.min
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else {
            return [-1, -1]
        }
        divide(nums, target, 0, nums.count - 1)
        return right < 0 ? [-1, -1] : [left, right]
    }
    
    func divide(_ nums: [Int], _ target: Int, _ start: Int, _ end: Int) {
        if start > end {
            return
        }
        
        let mid = start + (end - start) >> 1
        // 一旦找到目标值，更新左右边界
        if nums[mid] == target {
            if mid < left {
                left = mid
            }
            if mid > right {
                right = mid
            }
        }
        // 如果 nums[mid] == target 的话，下面两个递归都会进行
        if nums[mid] <= target {
            divide(nums, target, mid + 1, end)
        }
        if nums[mid] >= target {
            divide(nums, target, start, mid - 1)
        }
    }
}
