// 不限买卖次数，只是再卖的时候多减去一个 交易费用 就可以
class Solution {
    func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        
        var mp = Array(repeating: Array(repeating: 0, count: 2), count: prices.count)
        mp[0][1] = -prices[0]
        
        for i in 1 ..< prices.count {
            mp[i][0] = max(mp[i - 1][0], mp[i - 1][1] + prices[i] - fee)
            mp[i][1] = max(mp[i - 1][1], mp[i - 1][0] - prices[i])
        }
        
        return mp[prices.count - 1][0]
    }
}

let s = Solution()
print(s.maxProfit([1, 3, 2, 8, 4, 9], 2)) //8
print(s.maxProfit([2,1,4], 2)) //1
