// faster than 100.00%，位运算解法果然很快，整体的搜索思路是一样的，只是判断位置是否合法的时候用了位运算的方式
// https://leetcode-cn.com/problems/n-queens-ii/solution/dfs-wei-yun-suan-jian-zhi-by-makeex/ 下面的第一个评论蛮好的
class Solution {
    var count = 0
    func totalNQueens(_ n: Int) -> Int {
        solve(n, 0, 0, 0, 0)
        return count
    }
    // col、pie、na 二进制的 0/1 分别表示这一行上 不会被攻击/会被攻击 的位置，比如 0100 表示 row 这一行中第 2 列会被攻击到
    func solve(_ n: Int, _ row: Int, _ col: Int, _ pie: Int, _ na: Int) {
        if row == n {
            count += 1
            return
        }
        var bits = ~(col | pie | na) // 三种情况相或，比如等到 1001 表示，第 2、3 列在横竖撇捺上都不会被攻击到，取反变成 0110，这样 1 就表示不会被攻击到的位置
        bits &= (1 << n - 1) // 因为上述取反操作，高位也全部会变成 1，这一步是为了抹掉高位的 1
        while bits > 0 { // > 0 表示 bits 中还存在 1，有就是还有可以尝试放置的位置
            let p = bits & -bits // 取出最低位的 1
            solve(n, row + 1, col | p, (pie | p) << 1, (na | p) >> 1)
            bits &= (bits - 1) // 去掉最低位的 1
        }
    }
}
