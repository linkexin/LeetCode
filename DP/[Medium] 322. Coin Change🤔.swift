// 有点像上楼梯问题，又有点像背包问题
// https://leetcode-cn.com/problems/coin-change/solution/322-ling-qian-dui-huan-by-leetcode-solution/ 官方题解的方法三描述的很清晰了
class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard coins.count > 0, amount > 0 else {
            return 0
        }
        
        var dp = Array(repeating: Int.max, count: amount + 1)
        dp[0] = 0
        for i in 1 ... amount {
            for c in coins {
                if i >= c {
                    dp[i] = dp[i - c] == Int.max ? dp[i] : min(dp[i], dp[i - c] + 1)
                }
            }
        }
        
        return dp[amount]  == Int.max ? -1 : dp[amount]
    }
}

// 一开始写的 贪心算法，但 [1, 6, 7], 30 这个 case 就可以看出不对了，不能用传统的贪心
class Solution0 {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard coins.count > 0, amount > 0 else {
            return 0
        }
        let coins = coins.sorted()
        var amount = amount
        var count = 0
        for coin in coins.reversed() {
            if amount / coin > 0 {
                count += (amount / coin)
                amount -= amount / coin * coin
            }
        }
        return amount > 0 ? -1 : count
    }
}

let s = Solution()
print(s.coinChange([2], 3)) // -1
print(s.coinChange([2, 5], 13)) // 5
print(s.coinChange([1, 6, 7], 30)) // 5
print(s.coinChange([186,419,83,408], 6249))// 20
