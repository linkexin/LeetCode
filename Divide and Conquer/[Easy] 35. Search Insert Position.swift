// 二分查找基础题
// 循环写法
class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var start = 0, end = nums.count - 1
        var mid = 0
        while start <= end {
            mid = start + (end - start) >> 1
            if nums[mid] == target {
               return mid
            }
            
            if target < nums[mid] {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        // 这里注意直接返回 start
        return start
    }
}

// 递归写法
class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        return divide(nums, target, 0, nums.count - 1)
    }
    
    func divide(_ nums: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int {
        if start > end {
            // 这里直接返回 start 即可
            return start
        }
        let mid = start + (end - start) >> 1
        if nums[mid] == target {
            return mid
        }
        if target < nums[mid] {
            return divide(nums, target, start, mid - 1)
        } else {
            return divide(nums, target, mid + 1, end)
        }
    }
}
