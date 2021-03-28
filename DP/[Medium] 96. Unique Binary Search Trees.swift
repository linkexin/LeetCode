// 一开始自己一直用 dfs 来解，没做出来
class Solution {
    func numTrees(_ n: Int) -> Int {
        var count = 0
        var used = [Int]()
        dfs(-1, &used, Int.max, Int.min, n, &count)
        return count
    }
    
    func dfs(_ rootValue: Int,
             _ used: inout [Int],
             _ max: Int,
             _ min: Int,
             _ n: Int,
             _ count: inout Int) {
        if used.count == n {
            count += 1
            print(used)
            return
        }
        
        for i in 1 ... n {
            if used.contains(i) {
                continue
            }
            if i < min || i > max {
                continue
            }
            used.append(i)
            if rootValue == -1 {
                dfs(i, &used, max, min, n, &count)
            } else {
                if rootValue < i {
                    dfs(i, &used, max, rootValue, n, &count)
                } else {
                    dfs(i, &used, rootValue, min, n, &count)
                }
            }
            used.removeLast()
        }
    }
}

// 一看题解是道 dp 真是要了命了
// 这个题解蛮好 https://leetcode-cn.com/problems/unique-binary-search-trees/solution/shou-hua-tu-jie-san-chong-xie-fa-dp-di-gui-ji-yi-h/
class Solution {
    func numTrees(_ n: Int) -> Int {
        guard n > 1 else {
            return 1
        }
        var dp = Array(repeating: 0, count: n + 1)
        dp[0] = 1
        dp[1] = 1
        for i in 2 ... n {
            for j in 0 ..< i {
                dp[i] += dp[j] * dp[i - j - 1]
            }
        }
        return dp[n]
    }
}
