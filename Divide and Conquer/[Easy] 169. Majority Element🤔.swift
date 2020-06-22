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
