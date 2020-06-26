// faster than 60.78%
class Solution {
    var result = [[Int]]()
    var column = Set<Int>()
    var pie = Set<Int>()
    var na = Set<Int>()
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var state = Array.init(repeating: 0, count: n)
        solve(n, 0, &state)
        return formatResult(n)
    }
    
    func solve(_ n: Int, _ row: Int, _ currentState: inout [Int]) {
        if row == n {
            result.append(currentState)
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
    
    func formatResult(_ n: Int) -> [[String]] {
        return result.map {
            return $0.map { index in
                var s = Array<Character>(repeating: ".", count: n)
                s[index] = "Q"
                return String(s)
            }
        }
    }
}

// faster than 74.51%
// 稍做优化，每次遍历结束就直接存储可以直接输出的答案，省去最后的 formatResult 操作
class Solution1 {
    var result = [[String]]()
    var column = Set<Int>()
    var pie = Set<Int>()
    var na = Set<Int>()
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var state = Array(repeating: Array(repeating: ".", count: n), count: n)
        solve(n, 0, &state)
        return result
    }
    
    func solve(_ n: Int, _ row: Int, _ currentState: inout [[String]]) {
        if row == n {
            // 把二维数组转成一维数组
            result.append(currentState.map {
                $0.reduce("", {
                    return $0 + $1
                })
            })
            return
        }
        for c in 0 ..< n {
            if !column.contains(c) && !pie.contains(row + c) && !na.contains(row - c) {
                column.insert(c)
                pie.insert(row + c)
                na.insert(row - c)
                currentState[row][c] = "Q"
                
                solve(n, row + 1, &currentState)
                
                column.remove(c)
                pie.remove(row + c)
                na.remove(row - c)
                currentState[row][c] = "."
            }
        }
    }
}
