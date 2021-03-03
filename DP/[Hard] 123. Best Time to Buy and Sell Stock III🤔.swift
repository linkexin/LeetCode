// 这道题真的是，你以为把状态转移方程列出来就完了？这道题的初始状态真的卡了我好久
// 首先需要明确，1 次交易 = 1 次买 + 1 次卖
// 定义 3 维数组，dp[i][k][j] 表示第 i 天，已经交易过 k 次，手上是否持有股票，j = 0 表示没持有，j = 1 表示持有
// 我写了两种解法，第一种是 买入算作一次交易，另一种是 买入再卖出算作一次交易
// 两种的状态转移方程其实只有微小的差别，但是前提是初始状态必须设置对
    
class Solution1 {
    // 买入再卖出算作 1 次交易
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        
        let K = 2
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

class Solution0 {
    // 买入算作 1 次交易
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }

        let K = 2
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: K + 1), count: prices.count)

        for k in 0 ... K {
            dp[0][k][1] = -prices[0] // 第 0 天手上持有股票，那只能是持有第一天的股票，因为没有手续费，可以在这一天买了卖卖了买，但因为最后还是要持有股票，所以只能是持有第 0 天的股票
        }
        for i in 0 ..< prices.count {
            dp[i][0][1] = Int.min // 无论第几天，0 次交易，且手上有股票，标记为不可能
        }

        for i in 1 ..< prices.count {
            for k in 0 ... K {
                dp[i][k][0] = max(dp[i - 1][k][0], dp[i - 1][k][1] + prices[i])
                dp[i][k][1] = k > 0 ? max(dp[i - 1][k][1], dp[i - 1][k - 1][0] - prices[i]) : dp[i - 1][k][1]
            }
        }
        var maxP = Int.min
        for k in 0 ... K {
            maxP = max(maxP, dp[prices.count - 1][k][0])
        }
        return maxP
    }
}
