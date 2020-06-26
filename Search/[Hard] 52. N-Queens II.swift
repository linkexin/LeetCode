// 和 51 题一毛一样，只是最后输出可能的结果的个数
class Solution {
    var result = 0
    var column = Set<Int>()
    var pie = Set<Int>()
    var na = Set<Int>()
    
    func totalNQueens(_ n: Int) -> Int {
        var state = Array.init(repeating: 0, count: n)
        solve(n, 0, &state)
        return result
    }
    
    func solve(_ n: Int, _ row: Int, _ currentState: inout [Int]) {
        if row == n {
            result += 1
            return
        }
        for c in 0 ..< n {
            if !column.contains(c) && !pie.contains(row + c) && !na.contains(row - c) {
                column.insert(c)
                pie.insert(row + c)
                na.insert(row - c)
                currentState[row] = c
                
                solve(n, row + 1, &currentState)
                
                column.remove(c)
                pie.remove(row + c)
                na.remove(row - c)
            }
        }
    }
}
