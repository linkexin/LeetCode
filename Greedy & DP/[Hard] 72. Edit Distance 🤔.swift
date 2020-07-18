// dp[i][j] 表示 w1 的前 i 个字符变换到 w2 的前 j 个字符需要的操作次数
// 类似两个字符串匹配的问题，dp[i][j] 这样的状态定义，就当做是经验记下来！
// 这道题理解状态方程倒是不难，但是计算 dp[i][j] 的时候判断的是 w1[i - 1] ==? w2[j - 1]，一下没绕过来😹
// 记住，这道题的 i、j 表示的是 前 i 位 和前 j 位，所以其实真正有意义的下标是从 1 开始的，但是 w1 w2 是从下标 0 开始的，注意这一点吧
class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        guard word1.count > 0 || word2.count > 0 else {
            return 0
        }
        var dp = Array(repeating: Array(repeating: 0, count: word2.count + 1), count: word1.count + 1)
        
        //[0...n]
        for i in 0 ..< word1.count + 1 {
            dp[i][0] = i
        }
        //[0...n]
        for j in 0 ..< word2.count + 1 {
            dp[0][j] = j
        }
        
        let w1 = Array(word1)
        let w2 = Array(word2)
        for i in 1 ..< w1.count + 1 {
            for j in 1 ..< w2.count + 1 {
                if w1[i - 1] == w2[j - 1] { // 注意这个下标是 -1 的
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    // 在添加、删除、替换中选一个
                    dp[i][j] = min(min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1
                }
            }
        }

        return dp[word1.count][word2.count]
    }
}
