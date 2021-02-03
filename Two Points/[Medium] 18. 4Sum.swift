// 直接套用了三数之和，结果还 WA 了几次
class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        guard nums.count >= 4 else {
            return []
        }
        var result = [[Int]]()
        // 为了避免重复结果，这里需要先排序，同时 threeSum 中的排序就可以省略了
        let nums = nums.sorted()
        for i in 0 ..< nums.count - 3 {
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            // WA：传递给 threeSum 的是 target - nums[i]
            let threeNums = threeSum(Array(nums[i + 1 ..< nums.count]), target - nums[i])
            if threeNums.count > 0 {
                for three in threeNums {
                    var t = three
                    t.insert(nums[i], at: 0)
                    result.append(t)
                }
            }
        }
        return result
    }
    
    func threeSum(_ nums: [Int], _ target: Int = 0) -> [[Int]] {
        guard nums.count >= 3 else {
            return []
        }
        var result = [[Int]]()
        for i in 0 ..< nums.count {
            // WA: 一开始写了这句，当数组中存在负数的时候，这里的判断就会出错
//                if (nums[i] > target) {
//                    break
//                }
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            var a = i + 1
            var b = nums.count - 1
            while a < nums.count && b >= 0 && a < b {
                if a != i + 1 && nums[a] == nums[a - 1] {
                    a += 1
                    continue
                }
                if b != nums.count - 1 && nums[b] == nums[b + 1] {
                    b -= 1
                    continue
                }
                
                let sum = nums[a] + nums[b] + nums[i]
                if sum == target {
                    result.append([nums[i], nums[a], nums[b]])
                    a += 1
                }
                if sum < target {
                    a += 1
                }
                if sum > target {
                    b -= 1
                }
            }
        }
        return result
    }
}

let s = Solution()
print(s.fourSum([1, 0, -1, 0, -2, 2], 0)) // [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
print(s.fourSum([0, 0, 0, 0], 0)) // [[0, 0, 0, 0]]
print(s.fourSum([0, 0, 0, 0], 1)) // []
print(s.fourSum([5,5,3,5,1,-5,1,-2], 4)) // [[-5, 1, 3, 5]] 注意这个 case 中的重复结果过滤
print(s.fourSum([1,-2,-5,-4,-3,3,3,5], -11)) // [[-5, -4, -3, 1]]
