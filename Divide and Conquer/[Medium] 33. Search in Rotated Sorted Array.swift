// 二分法，有点像是二分查抄的升级版，只是在递归之前，先判断左右的子区间是不是在连续递增且在 target 是否在递增区间内
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
        if !(target < nums[begin] && target > nums[min] && nums[begin] + (min - begin) == nums[min]) {
            left = recursion(nums, target, begin, min)
        }
        if !(target < nums[min + 1] && target > nums[end] && nums[min] + (end - min) == nums[end]) {
            right = recursion(nums, target, min + 1, end)
        }
        return left == -1 ? right : left
    }
}

let s = Solution()
print(s.search([4,5,6,7,0,1,2], 7))
