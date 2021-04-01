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

// 大体思路就是后序遍历，先右节点、再处理 root 节点，再左节点
// 遍历过程中维护一个 sum，一直将遍历过的所有节点的值累加起来
class Solution {
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        var sum = 0
        convert(root, &sum)
        return root
    }
    
    func convert(_ root: TreeNode?, _ sum: inout Int) {
        if root == nil {
            return
        }
        // 先右节点
        convert(root?.right, &sum)
        // 再处理本身节点
        let val = root?.val ?? 0
        root?.val += sum
        sum += val
        // 再左节点
        convert(root?.left, &sum)
    }
    
    func leftConvert(_ root: TreeNode?, _ sum: Int) {
        if root == nil {
            return
        }
        root?.val += sum
        leftConvert(root?.left, root?.val ?? 0)
    }
}

let s = Solution()

let t1 = TreeNode(4)
let t2 = TreeNode(1)
let t3 = TreeNode(6)

let t4 = TreeNode(0)
let t5 = TreeNode(2)
let t6 = TreeNode(5)
let t7 = TreeNode(7)
let t8 = TreeNode(2)
let t9 = TreeNode(5)
let t10 = TreeNode(22)

t1.left = t2
t1.right = t3
t2.left = t4
t2.right = t5
t5.right = TreeNode(3)

t3.left = t6
t3.right = t7
t7.right = TreeNode(8)

print(s.convertBST(t1))
