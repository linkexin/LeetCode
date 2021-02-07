// 二分法，有点像是二分查找的升级版，只是在递归之前，先判断左右的子区间是不是在连续递增且 target 是否在递增区间内
// 如果子区间是递增区间，且 target 不在区间内，那就没必要去遍历这个子区间了
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        return recursion(nums, target, 0, nums.count - 1)
    }
    
    func recursion(_ nums: [Int], _ target: Int, _ begin: Int, _ end: Int) -> Int {
        guard begin <= end else {
            return -1
        }
//            if nums[begin] == target {
//                return begin
//            }
//            if nums[end] == target {
//                return end
//            }
        if begin == end {
            return nums[begin] == target ? begin : -1
        }
        let min = (begin + end) / 2
        var left = -1, right = -1
        // 感觉这里递增的判断不太对
        if !(target < nums[begin] && target > nums[min] && nums[begin] + (min - begin) == nums[min]) {
            left = recursion(nums, target, begin, min)
        }
        if !(target < nums[min + 1] && target > nums[end] && nums[min] + (end - min) == nums[end]) {
            right = recursion(nums, target, min + 1, end)
        }
        return left == -1 ? right : left
    }
}

// 2021.02.07 
// https://leetcode-cn.com/problems/search-in-rotated-sorted-array/solution/duo-si-lu-wan-quan-gong-lue-bi-xu-miao-dong-by-swe/
// 普通的二分，通过比较 nums[mid] 和 target 来更新 start 和 end 边界
// 而这题因为数组不是完全有序的，所有还要有一些额外的判断条件，这道题包含了两个有序数列
// 我们的大体思路是，将 target 的范围缩小的两个递增序列的其中一个上，确定到一个递增序列上后，就可以使用普通的二分求解了
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        var start = 0, end = nums.count - 1
        while start <= end {
            let mid = start + (end - start) >> 1
            if nums[mid] == target {
                return mid
            }
            
            // 因为递增数组进行了一次翻转，所以第一段有序数组的值一定大于第二段有序数组的值，
            // 如果 nums[mid] 和 nums[start] 在同一个有序数列上，则 nums[mid] > nums[start]
            
            // [start, mid] 是递增的，那么就代表 [mid, end] 这段不是递增的
            if nums[mid] >= nums[start] {
                if target < nums[mid] && target >= nums[start] {
                    // 如果 target 落在递增范围内，那么继续在递增这一段查找即可
                    end = mid - 1
                } else {
                    // 如果 target 不落在递增范围内，直接跳过递增这一段不查找
                    start = mid + 1
                }
            } else {
                // nums[mid] < nums[start] 说明 [start, mid] 这段不是递增的，而 [mid, end] 这段是递增的
                if target > nums[mid] && target <= nums[end] {
                    // 如果 target 落在递增范围内，那么继续在递增这一段查找即可
                    start = mid + 1
                } else {
                    // 如果 target 不落在递增范围内，直接跳过递增这一段不查找
                    end = mid - 1
                }
            }
        }
        return -1
    }
}

let s = Solution()
print(s.search([4,5,6,7,0,1,2], 7))
