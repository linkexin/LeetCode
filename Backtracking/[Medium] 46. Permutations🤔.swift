// faster than 8.16%
class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var arr = Array(repeating: 0, count: nums.count)
        var re = [[Int]]()
        var used = [Int: Bool]()
        permutation(nums, 0, &used, &arr, &re)
        return re
    }
    
    // 每次递归，决定 index 这个位置放置哪个数
    func permutation(_ nums: [Int], _ index: Int, _ used: inout [Int: Bool], _ arr: inout [Int], _ re: inout [[Int]]) {
        if index == nums.count {
            re.append(arr)
            return
        }
        for n in nums {
            if used[n] == nil || used[n] == false {
                used[n] = true
                arr[index] = n // index 位置放置 n，接着递归
                permutation(nums, index + 1, &used, &arr, &re)
                used[n] = false // index 位置不放置 n，接着循环，找下一个没有被用过的数
            }
        }
    }
}
