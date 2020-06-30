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
