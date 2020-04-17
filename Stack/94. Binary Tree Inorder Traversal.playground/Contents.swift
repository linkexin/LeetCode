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

// 更像是个递归题
class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let node = root else {
            return []
        }
        
        var output = [Int]()
        output.append(contentsOf: inorderTraversal(node.left))
        output.append(node.val)
        output.append(contentsOf: inorderTraversal(node.right))
        return output
    }
}

let s = Solution()
let n1 = TreeNode(1)
let n2 = TreeNode(2)
let n3 = TreeNode(3)
let n4 = TreeNode(4)
let n5 = TreeNode(5)
let n6 = TreeNode(6)
n1.right = n2
n2.left = n3
n2.right = n4
n4.left = n5
n5.right = n6
s.inorderTraversal(n1) // [1, 3, 2, 5, 6, 4]
