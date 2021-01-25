//// O(N²)
//class Solution {
//    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
//        for i in 0 ... nums.count - 1  {
//            for j in i + 1 ... nums.count - 1 {
//                if nums[i] + nums[j] == target {
//                    return [i, j]
//                }
//            }
//        }
//        return [0, 0]
//    }
//}

// O(N)
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // num -> index
        var dic = [Int: Int]()
        for (i, n) in nums.enumerated() {
            if dic[target - n] != nil {
                return [dic[target - n]!, i]
            } else {
                dic[n] = i
            }
        }
        return []
    }
}

let s = Solution()
s.twoSum([11, 15, 2, 7], 9)
s.twoSum([2, 7, 11, 15], 9)
