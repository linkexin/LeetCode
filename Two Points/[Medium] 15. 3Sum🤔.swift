// 看到题解标题写着「排序+双指针」大概想到了解法，但是卡在了一些边缘 case
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        guard nums.count >= 3 else {
            return result
        }
        var a = nums
        a.sort{ $0 < $1 }

        // index 的范围要注意
        for index in 0...a.count - 3 {
            // 最小的数都大于 0 了，证明无解
            if a[index] > 0 {
                break
            }
            if index > 0 && a[index] == a[index - 1] {
                continue
            }
            
            var left = index + 1, right = a.count - 1
            while left != right {
                // left 需要和上个 left 的值不同，不然有可能输出两个相同的值
                if left != index + 1 && a[left] == a[left - 1] {
                    left += 1
                    continue
                }
                if right < a.count - 1 && a[right] == a[right + 1] {
                    right -= 1
                    continue
                }
                let re = a[index] + a[left] + a[right]
                if re < 0 {
                    left += 1
                } else if re > 0 {
                    right -= 1
                } else {
                    result.append([a[index], a[left], a[right]])
                    left += 1
                }
            }
        }
        return result
    }
}

let s = Solution()
s.threeSum([-2,0,0,2,2])
s.threeSum([-1, 0, 1, 2, -1, -4])
s.threeSum([0, 0, 0, 0])
s.threeSum([-4,-2,-1])
