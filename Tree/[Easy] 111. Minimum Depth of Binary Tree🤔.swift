public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// faster than 68.33%
// 深搜，分别求左右子树的层级，返回 较小层级 + 1，注意需要对 0 层级特别判断
// 考虑 [3, 5] 这个 case，根节点的右子树是 nil，如果不对 0 层级做特殊判断，最终会得到 1 这个错误结果
class Solution {
    func minDepth(_ root: TreeNode?) -> Int {
        return dfs(root)
    }
    
    func dfs(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let left = dfs(root?.left)
        let right = dfs(root?.right)
        if left == 0 {
            return right + 1
        }
        if right == 0 {
            return left + 1
        }
        return left > right ? right + 1 : left + 1
    }
}

// 2020.02.08 bfs 版本，感觉最小深度用 bfs 做更符合思维习惯
class Solution {
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var queue = [TreeNode]()
        queue.append(root)
        
        var level = 1
        while queue.count > 0 {
            let levelNode = queue
            queue = [TreeNode]() // array 是值类型
            for node in levelNode {
                // 找到第一个叶子节点，直接返回当前 level
                if node.left == nil && node.right == nil {
                    return level
                }
                if let l = node.left {
                    queue.insert(l, at: 0)
                }
                if let r = node.right {
                    queue.insert(r, at: 0)
                }
            }
            level += 1
        }
        return level
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
print(s.minDepth(l1))
print("done")
