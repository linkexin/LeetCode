// 直接先用 filter 把 0 踢走，然后再在后面补 0
// faster than 94.81%，less than 21.78%，时间复杂度可以，空间复杂度不太好
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        let n = nums.count
        nums = nums.filter{ $0 != 0 }
        for _ in 0 ..< n - nums.count {
            nums.append(0)
        }
    }
}

// 快慢指针，faster than 94.81，less than 70.69%，空间复杂度优化了不少
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        var fast = 0, slow = 0
        while fast < nums.count && slow < nums.count {
            if nums[fast] != 0 {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        while slow < nums.count {
            nums[slow] = 0
            slow += 1
        }
    }
}
