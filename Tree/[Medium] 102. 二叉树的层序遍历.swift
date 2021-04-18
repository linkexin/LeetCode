public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// faster than 84.98%，dfs
class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        dfs(root, 0, &result)
        return result
    }
    
    func dfs(_ root: TreeNode?, _ level: Int, _ result: inout [[Int]]) {
        guard root != nil else {
            return
        }
        if result.count <= level {
            result.append([])
        }
        result[level].append(root?.val ?? 0)
        dfs(root?.left, level + 1, &result)
        dfs(root?.right, level + 1, &result)
    }
}

// 2020.02.08 补充 bfs 的方式
class Solution {
    private var levels = [[Int]]()
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        bfs(root)
        return levels
    }
    
    func bfs(_ root: TreeNode) {
        var queue = [TreeNode]()
        queue.append(root)
        
        while queue.count > 0 {
            var level = [Int]()
            for i in (0 ..< queue.count).reversed() {
                level.append(queue[i].val)
            }
            levels.append(level)
            for _ in 0 ..< queue.count {
                let node = queue.removeLast()
                if let l = node.left {
                    queue.insert(l, at: 0)
                }
                if let r = node.right {
                    queue.insert(r, at: 0)
                }
            }
        }
    }
}

let l1 = TreeNode(3)
let l2 = TreeNode(5)
l1.left = l2
let l3 = TreeNode(1)
l1.right = l3

let l4 = TreeNode(6)
l2.left = l4
let l5 = TreeNode(2)
l2.right = l5

let l6 = TreeNode(0)
l3.left = l6
let l7 = TreeNode(8)
l3.right = l7

let l8 = TreeNode(7)
l5.left = l8
let l9 = TreeNode(4)
l5.right = l9

let s = Solution()
print(s.levelOrder(nil))
