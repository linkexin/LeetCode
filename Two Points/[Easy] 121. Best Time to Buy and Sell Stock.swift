// O(n²)
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0
        }
        var tMax = 0
        for i in 0...prices.count - 2 {
            var sMax = 0
            for j in i + 1...prices.count - 1 {
                sMax = max(prices[j] - prices[i], sMax)
            }
            tMax = max(sMax, tMax)
        }
        return tMax
    }
}

// O(n)
class Solution1 {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0
        }
        var tMax = 0
        var minValue = Int.max
        for i in 0...prices.count - 1 {
            if minValue > prices[i] {
                minValue = prices[i]
            } else {
                tMax = max(tMax, prices[i] - minValue)
            }
        }
        return tMax
    }
}

// 还有一种动规解法，见动规目录

let s = Solution()
s.maxProfit([1, 2, 3, 4,7])
