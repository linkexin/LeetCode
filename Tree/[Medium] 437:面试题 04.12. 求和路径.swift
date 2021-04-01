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

// dfs 一遍过 87.50%，12.50%
class Solution {
    func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
        var count = 0
        dfs(root, [], sum, &count)
        return count
    }
    
    func dfs(_ root: TreeNode?, _ currentSums: [Int], _ sum: Int, _ count: inout Int) {
        guard let root = root else {
            return
        }
        var newSums = [Int]()
        for i in 0 ..< currentSums.count {
            let add = currentSums[i] + root.val
            newSums.append(add)
            if add == sum {
                count += 1
            }
        }
        if root.val == sum {
            count += 1
        }
        newSums.append(root.val)
        dfs(root.left, newSums, sum, &count)
        dfs(root.right, newSums, sum, &count)
    }
}

let s = Solution()

let t1 = TreeNode(5)
let t2 = TreeNode(4)
let t3 = TreeNode(8)
let t4 = TreeNode(11)
let t5 = TreeNode(13)
let t6 = TreeNode(4)
let t7 = TreeNode(7)
let t8 = TreeNode(2)
let t9 = TreeNode(5)
let t10 = TreeNode(22)

t1.left = t2
t1.right = t3

t2.left = t4
t3.left = t5
t3.right = t6

t4.left = t7
t4.right = t8
t5.left = TreeNode(-4)
t6.left = t9
t6.right = t10
print(s.pathSum(t1, 22)) // 5
