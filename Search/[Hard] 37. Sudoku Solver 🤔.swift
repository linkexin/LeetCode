// faster than 35.90%
class Solution {
    func solveSudoku(_ board: inout [[Character]]) {
        _ = solve(&board)
    }
    
    // 注意这个方法的返回值
    func solve(_ board: inout [[Character]]) -> Bool {
        for i in 0 ..< board.count {
            for j in 0 ..< board.count {
                if board[i][j] != "." {
                    continue
                }
                for c in 1 ... 9 {
                    let k = Character(UnicodeScalar(c + 48)!)
                    if isValid(board, i, j, k) {
                        board[i][j] = k
                        if (solve(&board)) {
                            return true
                        } else {
                            board[i][j] = "."
                        }
                    }
                }
                return false
            }
        }
        return true
    }
    
    func isValid(_ board: [[Character]], _ i: Int, _ j: Int, _ c: Character) -> Bool {
        for row in 0 ..< board.count {
            if c == board[row][j] {
                return false
            }
        }
        if board[i].contains(c) {
            return false
        }
        for p in i / 3 * 3 ..< i / 3 * 3 + 3 {
            for q in j / 3 * 3 ..< j / 3 * 3 + 3 {
                if board[p][q] == c {
                    return false
                }
            }
        }
        return true
    }
    // 下面这种方法可能更好一点
    func isValid1(_ board: [[Character]], _ i: Int, _ j: Int, _ c: Character) -> Bool{
        for m in 0 ..< 9 {
            if board[i][m] != "." && board[i][m] == c {
                return false
            }

            if board[m][j] != "." && board[m][j] == c {
                return false
            }

            let rowIndex = i / 3 * 3 + m / 3
            let colIndex = j / 3 * 3 + m % 3
            if board[rowIndex][colIndex] != "." && board[rowIndex][colIndex] == c {
                return false
            }
        }
        return true
    }
}
