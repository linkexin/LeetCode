class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 && matrix.first?.count ?? 0 > 0 else {
            return []
        }
        var matrix = matrix
        let step = [(0, 1), (1, 0), (0, -1), (-1, 0)] // 右，下，左，上
        var spiral = [Int]()
        var i = 0, j = 0, z = 0, s = step[z], maxCount = 0
        // 第一次 A 这里写的是 > 4，结果只 faster than 5%，改成 3 以后就 faster than 68.72% 了
        while maxCount < 3 {
            if matrix[i][j] != Int.max {
                spiral.append(matrix[i][j])
                matrix[i][j] = Int.max
                maxCount = 0
            }
            let ni = i + s.0, nj = j + s.1
            if ni >= 0 && nj >= 0 && matrix.count > ni && matrix[ni].count > nj && matrix[ni][nj] != Int.max {
                i = ni
                j = nj
            } else {
                z = (z + 1) % 4
                s = step[z]
                maxCount += 1
            }
        }
            
        return spiral
    }
}

let s = Solution()
print(s.spiralOrder([
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9,10,11,12],
  [13, 14, 15, 16],
]))
