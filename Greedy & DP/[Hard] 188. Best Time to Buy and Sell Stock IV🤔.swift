// dp 的解法在 123 题中解释
class Solution {
    func maxProfit(_ K: Int, _ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        if K >= prices.count / 2 {
            // 这种情况下其实就是无限买卖次数，那直接贪心即可
            return greedy(prices)
        }
        return dp(K, prices)
    }
    
    func greedy(_ prices: [Int]) -> Int {
        var profit = 0
        for i in 1 ..< prices.count {
            if prices[i] > prices[i - 1] {
                profit += (prices[i] - prices[i - 1])
            }
        }
        return profit
    }
    
    func dp(_ K: Int, _ prices: [Int]) -> Int {
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: K + 1), count: prices.count)
        
        // 初始状态的设定也很重要
        for k in 0 ... K {
            dp[0][k][0] = 0
            dp[0][k][1] = -prices[0] // 第 0 天手上持有股票，那只能是持有第一天的股票，因为没有手续费，可以在这一天买了卖卖了买，但因为最后还是要持有股票，所以只能是持有第 0 天的股票
        }
        for i in 1 ..< prices.count {
            dp[i][0][1] = Int.min // 无论第几天，0 次交易，且手上有股票，标记为不可能
        }
        
        for i in 1 ..< prices.count {
            for k in 0 ... K {
                // 买入再卖出算作 1 次交易
                dp[i][k][0] = k > 0 ? max(dp[i - 1][k][0], dp[i - 1][k - 1][1] + prices[i]) : dp[i - 1][k][0]
                dp[i][k][1] = max(dp[i - 1][k][1], dp[i - 1][k][0] - prices[i])
            }
        }
        var maxP = 0
        for k in 0 ... K {
            maxP = max(maxP, dp[prices.count - 1][k][0])
        }
        return maxP
    }
}
