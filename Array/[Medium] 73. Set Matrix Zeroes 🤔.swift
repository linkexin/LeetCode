class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        guard matrix.count > 0 else {
            return
        }
        guard matrix[0].count > 0 else {
            return
        }
        
        //第一列是否有 0
        var isCol = false
        for i in 0 ..< matrix.count {
            if (matrix[i][0] == 0) {
                isCol = true
            }
        }
        // 第一行是否有 0
        var isRow = false
        for j in 0 ..< matrix[0].count {
            if (matrix[0][j] == 0) {
                isRow = true
            }
        }
        
        // 把第二行和第二列当做标记位
        for i in 1 ..< matrix.count {
            for j in 1 ..< matrix[i].count {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        // 遍历除第一行第一列外的所有元素，如果标记位为 0，则把本身置 0
        for i in 1 ..< matrix.count {
            for j in 1 ..< matrix[i].count {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        // 设置第一行
        if isRow == true {
            for j in 0 ..< matrix[0].count {
                matrix[0][j] = 0
            }
        }
        // 设置第一列
        if isCol == true {
            for i in 0 ..< matrix.count {
                matrix[i][0] = 0
            }
        }
    }
}
