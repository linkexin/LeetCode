// 贪心，每次持有 1 股，每天可以买无数次，因为买卖次数不限制，所以可以用贪心
// 只有前一天比后一天价格高，那么就有的赚，
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var profit = 0
        for i in 0 ..< prices.count - 1 {
            if prices[i] < prices[i + 1] {
                profit += (prices[i + 1] - prices[i])
            }
        }
        return profit
    }
}

// 动规解法，其实第二个维度一开始不容易想到，主要是需要理解题目的每次手上只能持有 1 支股票
// dp[i][0] 表示第 i 天能获得的最大收益，0 表示当前没有持有股票
// dp[i][0] 表示第 i 天能获得的最大收益，1 表示当前持有股票
// 每天的操作情况可以分为：
// 1. 手上没有股票的可以选择不操作或者买入
// 2. 手上有股票的可以选择操不操作或者卖出
class Solution1 {
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        
        var dp = Array(repeating: Array(repeating: 0, count: 2), count: prices.count)
        dp[0][0] = 0 // 第 0 天且手上没有股票的最大收益是 0
        dp[0][1] = -prices[0] // 第 0 天且手上有股票的最大收益是 负第一天的价格
        
        for i in 1 ..< prices.count {
            // 当天且手上没有股票的最大利润 = max(前一天手上没有股票的最大利润，当天买进以后的最大利润)
            dp[i][0] = max(dp[i - 1][0], dp[i - 1][1] + prices[i])
            // 当天且手上有股票的最大利润 = max(前一天手上有股票的最大利润，当天卖出以后的最大利润)
            dp[i][1] = max(dp[i - 1][1], dp[i - 1][0] - prices[i])
        }
        
        // 最大利润一定是手上的股票都卖出了
        return dp[prices.count - 1][0]
    }
}
