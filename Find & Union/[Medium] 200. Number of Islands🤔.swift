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
    // 递归将四周标记为 0，用的 dfs
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

// -------------------------------------------
struct UnionFind {
    var count = 0 // 表示内部集合的 count，并不是元素个数
    var parent: [Int]
    var rank: [Int]
    
    init(_ grid: [[Character]]) {
        let m = grid.count
        let n = grid[0].count
        parent = Array(repeating: 0, count: m * n)
        rank = Array(repeating: 0, count: m * n)
        for i in 0 ..< m {
            for j in 0 ..< n {
                if grid[i][j] == "1" {
                    parent[i * n + j] = i * n + j // 注意这里用的是 n，不是 m = =
                    count += 1
                }
            }
        }
    }
    
    func find(_ i: Int) -> Int {
        if parent[i] == i {
            return i
        }
        return find(parent[i])
    }
    
    mutating func union(_ i: Int, _ j: Int) {
        let rooti = find(i)
        let rootj = find(j)
        
        if rooti == rootj {
            return
        }
        // 优雅的写法：深度小的往深度大的集合上合并，这样可以避免集合深度过大，find 的时候层级太多影响效率
        if rank[rooti] > rank[rootj] {
            parent[rootj] = rooti
        } else if rank[rooti] < rank[rootj] {
            parent[rooti] = rootj
        } else {
            parent[rootj] = rooti
            // 深度需要 + 1
            rank[rooti] += 1
        }
        // 两个集合合并成一个集合了，所以集合数 - 1
        count -= 1
    }
}

// faster than 58.82%，并查集方法
// 遍历地图，遇到 1，就将周围的节点和自己的节点合并成一个集合，最后返回集合的个数即可
class Solution1 {
    // 上 下 左 右
    let dir = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0 else {
            return 0
        }
        var uf = UnionFind(grid)
        let m = grid.count
        let n = grid[0].count
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                if grid[i][j] == "0" {
                    continue
                }
                for d in dir {
                    let x = i + d.0
                    let y = j + d.1
                    if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == "1" {
                        // 本身是 1 且四周也有 1，将四周和自己合并到一个集合中
                        uf.union(i * n + j, x * n + y)
                    }
                }
            }
        }
        
        return uf.count
    }
}

