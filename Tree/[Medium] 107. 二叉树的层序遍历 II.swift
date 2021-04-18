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

// 搞定层序遍历以后这题就轻轻松松
class Solution {
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var result: [[Int]] = []
        guard let root = root else {
            return result
        }
        var queue = [TreeNode]()
        queue.append(root)
        while !queue.isEmpty {
            var levelQueue = queue
            queue = [TreeNode]()
            var level = [Int]()
            while !levelQueue.isEmpty {
                let top = levelQueue.removeFirst()
                if let left = top.left {
                    queue.append(left)
                }
                if let right = top.right {
                    queue.append(right)
                }
                level.append(top.val)
            }
            result.insert(level, at: 0)
        }
        return result
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
print(s.levelOrderBottom(nil))
