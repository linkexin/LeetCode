class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        if n == 1 {
            return x
        }
        if n < 0 {
            return 1.0 / myPow(x, -n)
        }
        
        let re = myPow(x, n / 2)
        if n % 2 == 0 {
            return re * re
        } else {
            // 如果是奇数还要再乘个 x
            return re * re * x
        }
    }
}
