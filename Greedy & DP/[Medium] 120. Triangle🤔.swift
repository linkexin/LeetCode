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
