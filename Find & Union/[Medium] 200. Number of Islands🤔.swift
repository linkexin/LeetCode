// faster than 66.31%，染色问题的思路，找到一个为 1，就递归的将它四周的地图都标记为 0
class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        var grid = grid
        var count = 0
        for i in 0 ..< grid.count {
            for j in 0 ..< grid[i].count {
                if grid[i][j] == "1" {
                    count += 1
                    
                    mark(&grid, i, j)
                }
            }
        }
        return count
    }
    
    // 上 下 左 右
    let dir = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    // 递归将四周标记为 0，用的深搜
    func mark(_ grid: inout [[Character]], _ i: Int, _ j: Int) {
        grid[i][j] = "0"
        for d in dir {
            let x = i + d.0
            let y = j + d.1
            if x >= 0 && x < grid.count && y >= 0 && y < grid[i].count && grid[x][y] == "1" {
                mark(&grid, x, y)
            }
        }
    }
}
