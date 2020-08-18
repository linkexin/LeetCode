// 用了泛型，稍微优化一下
struct UnionFind<T: Hashable> {
    var count = 0 // 表示内部集合的 count，并不是元素个数
    var parent: [Int]
    var rank: [Int]
    
    init(_ grid: [[T]]) {
        let m = grid.count
        parent = Array(repeating: 0, count: m)
        rank = Array(repeating: 0, count: m)
        // 在这个具体问题中，并查集的初始 union 数为朋友圈里人的个数，也就是二维数组的边长即可
        for i in 0 ..< m {
            parent[i] = i
            count += 1
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

// faster than 80.00%，并查集
class Solution {
    func findCircleNum(_ M: [[Int]]) -> Int {
        let grid = M
        guard grid.count > 0 else {
            return 0
        }
        var uf = UnionFind(grid)
        let m = grid.count
        let n = grid[0].count
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                // 自己和自己不需要再 union 了
                if grid[i][j] == 0 || i == j {
                    continue
                }
                // i j 两个人认识，就将两个人的朋友圈 union 起来
                uf.union(i, j)
            }
        }
        
        return uf.count
    }
}
