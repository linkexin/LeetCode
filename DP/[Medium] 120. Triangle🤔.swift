// faster than 96.10% https://time.geekbang.org/course/detail/100019701-69780
// 刚开始自己想的时候，从顶往下推，最后确实是写出式子了，但是这种方式跟递归就没太大区别了
// dp 应该从最终结果往前推
class Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        let m = triangle.last?.count ?? 0
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: m), count: n)
        dp[n - 1] = triangle[n - 1]
        
        for i in (0 ..< n - 1).reversed() {
            for j in 0 ..< triangle[i].count {
                dp[i][j] = min(dp[i + 1][j], dp[i + 1][j + 1]) + triangle[i][j]
            }
        }
        
        return dp[0][0]
    }
}

// 因为 dp 中的值用过一次以后就不会再用了，所以进项状态压缩，将二维数据压缩成一维数组，然后不断复用本身
// 这样空间复杂度就可以减小到 O(N)
// Memory Usage less than 100.00%
class Solution1 {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var dp = triangle.last ?? []
        
        for i in (0 ..< n - 1).reversed() {
            for j in 0 ..< triangle[i].count {
                dp[j] = min(dp[j], dp[j + 1]) + triangle[i][j]
            }
        }
        
        return dp[0]
    }
}
