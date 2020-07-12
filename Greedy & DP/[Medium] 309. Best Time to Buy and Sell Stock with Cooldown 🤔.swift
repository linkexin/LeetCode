// 可以无限次买卖，但是有 cooldown 时间，也就是这次买距离上次买至少要隔 1 天时间
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        
        var mp = Array(repeating: Array(repeating: 0, count: 2), count: prices.count)
        mp[0][1] = -prices[0]
        
        for i in 1 ..< prices.count {
            mp[i][0] = max(mp[i - 1][0], mp[i - 1][1] + prices[i])
            if i >= 2 {
                mp[i][1] = max(mp[i - 1][1], mp[i - 2][0] - prices[i])
            } else {
                // 在第1天想买的时候，不用考虑 cooldown，因为前面还没有卖出过
                mp[i][1] = max(mp[i - 1][1], mp[i - 1][0] - prices[i])
            }
            
            // 一开始写成下面这样，WA了，就是没有考虑第一天的情况
            // mp[i][1] = i >= 2 ? max(mp[i - 1][1], mp[i - 2][0] - prices[i]) : mp[i - 1][1]
        }
        
        return mp[prices.count - 1][0]
    }
}

let s = Solution()
print(s.maxProfit([1,2,3,0,2])) //3
print(s.maxProfit([2,1,4])) //3
