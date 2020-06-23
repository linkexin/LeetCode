// O(n), faster than 65.90%
// 涉及到 count 的题目，就会想到用 map，
class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        var max = 0, maxVal = 0
        for n in nums {
            map[n, default: 0] += 1
            if max < map[n]! {
                max = map[n]!
                maxVal = n
            }
        }
        return maxVal
    }
}


// O(nlogn), faster than 29.23%
// 排序以后取中间位置的值
class Solution1 {
    func majorityElement(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        return nums[nums.count / 2]
    }
}

// O(logn) faster than 91.84%
// 分治，分别求解左右子范围内出现次数最多的数，再比较左右结果
// 1. 如果左右子范围内出现次数最多的数是同一个数，那么合并起来肯定也是它最多，直接返回
// 2. 如果左右子范围内出现次数最多的数不是同一个数，分别再数这两个数具体出现的次数，返回次数较多的那个
class Solution2 {
    func majorityElement(_ nums: [Int]) -> Int {
        return divide(nums, 0, nums.count - 1)
    }
    
    func divide(_ nums: [Int], _ start: Int, _ end: Int) -> Int {
        if start == end {
            return nums[start]
        }
        
        let mid = (end - start) / 2 + start
        let left = divide(nums, start, mid)
        let right = divide(nums, mid + 1, end)
        if left == right {
            return left
        }
        // 左右结果不一样的时候，单独再去数两个数在限定区间内的个数，在写的时候没想到 = =
        let leftCount = countInRange(nums, start, end, left)
        let rightCount = countInRange(nums, start, end, right)
        if leftCount >= rightCount {
            return left
        }
        return right
    }
    
    func countInRange(_ nums: [Int], _ start: Int, _ end: Int, _ n: Int) -> Int {
        var count = 0
        for i in start ... end {
            if nums[i] == n {
                count += 1
            }
        }
        return count
    }
}
