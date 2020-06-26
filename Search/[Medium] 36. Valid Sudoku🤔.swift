// faster than 96.49%
// 判断是否符合数独的定义，两重 for 循环，最主要的是小的 9 宫格内的判断逻辑怎么写
class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for i in 0 ..< 9 {
            var row = Array(repeating: 0, count: 10)
            var col = Array(repeating: 0, count: 10)
            var cube = Array(repeating: 0, count: 10)
            
            for j in 0 ..< 9 {
                if board[i][j] != "." {
                    let c = Int(board[i][j].asciiValue! - 48)
                    if row[c] > 0 {
                        return false
                    }
                    row[c] += 1
                }
                
                if board[j][i] != "." {
                    let c1 = Int(board[j][i].asciiValue! - 48)
                    if col[c1] > 0 {
                        return false
                    }
                    col[c1] += 1
                }
                
                let rowIndex = 3 * (i / 3)
                let colIndex = 3 * (i % 3)
//                print(rowIndex, colIndex)
//                print(rowIndex + j / 3, colIndex + j % 3)
//                print("------")
                if (board[rowIndex + j / 3][colIndex + j % 3] != ".") {
                    let c2 = Int(board[rowIndex + j / 3][colIndex + j % 3].asciiValue! - 48)
                    if cube[c2] > 0 {
                        return false
                    }
                    cube[c2] += 1
                }
            }
        }
        return true
    }
}
