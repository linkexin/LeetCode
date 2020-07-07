// 动规 O(n), dp[i] 表示前 i 天的最大利润
// 第 i 天的时候，可以选择买或者不买，如果不买，第 i 天的最大利润就等于第 i - 1 天的最大利润：dp[i] = dp[i - 1]
// 如果买，第 i 天的最大利润 = 第 i 天的价格 - 之前的最低价格，所以我们需要保留一个变量，不同更新之前的最低价格
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        var dp = Array(repeating: 0, count: prices.count)
        dp[0] = 0 // 第 0 天的最大利润是 0
        var minPrice = prices[0] // 最小价格的初始值等于第 0 天价格
        
        for i in 1 ..< prices.count {
            dp[i] = max(dp[i - 1], prices[i] - minPrice) // 买 和 不买 中取一个最大利润结果
            minPrice = min(minPrice, prices[i]) // 更新最小价格
        }
        
        return dp[prices.count - 1]
    }
}

let s = Solution()
s.maxProfit([1, 2, 3, 4,7])
