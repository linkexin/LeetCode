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
