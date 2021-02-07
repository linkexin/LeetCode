// 递归解法，faster than 67.38%
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        if n < 0 {
            return 1.0 / myPow(x, -n)
        }
        
        let re = myPow(x, n >>= 1)
        if n & 1 == 1 {
            return re * re
        } else {
            // 如果是奇数还要再乘个 x
            return re * re * x
        }
    }
}

// 快速幂方式，一定要掌握
// 非递归方法，倒着想反而不太顺，faster than 97.00%
class Solution1 {
    func myPow(_ x: Double, _ n: Int) -> Double {
        var x = x, n = n
        if n < 0 {
            n = -n
            x = 1 / x
        }
        var pow = 1.0
        while n > 0 {
            // 最后一个循环 n = 1，会将之前的结果更新到 pow 上
            if n & 1 == 1 {
                pow *= x
            }
            // x 持续更新自己的值
            x *= x
            n >>= 1
        }
        return pow
    }
}
