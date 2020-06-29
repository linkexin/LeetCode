// faster than 50.00%
// 二分法，右边界从 x / 2 开始，下面建议把 mid * mid 和 x 的比较都改为 mid == x / mid，mid < x / mid，这是因为 x 比较大的时候，mid * mid 可能会超过 Int 的最大范围，用除法的方式写可以避免这种情况
class Solution {
    func mySqrt(_ x: Int) -> Int {
        guard x > 1 else {
            return x
        }
        return dichotomy(x)
    }
    
    func dichotomy(_ x: Int) -> Int {
        var left = 0, right = x / 2
        var result = 0
        while left <= right {
            let mid = left + (right - left) / 2
            if mid * mid == x {
                return mid
            }
            if mid * mid < x {
                result = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return result
    }
}
