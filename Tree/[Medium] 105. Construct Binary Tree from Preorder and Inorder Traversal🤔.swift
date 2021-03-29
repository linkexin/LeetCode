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

// 官方题解的视频讲的很好，按照官方思路实现即可，faster than 100.00%
class Solution {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.count == inorder.count else {
            return nil
        }
        // 为了在中序遍历中找到根节点的位置，这里先把中序遍历中值和位置存在一个 hash 表中
        var inMap = [Int: Int]()
        for (i, v) in inorder.enumerated() {
            inMap[v] = i
        }
        return build(preorder, 0, preorder.count - 1, inorder, 0, inorder.count, inMap)
    }
    
    func build(_ preorder: [Int], _ preLeft: Int, _ preRight: Int, _ inorder: [Int], _ inLeft: Int, _ inRight: Int, _ inMap: [Int: Int]) -> TreeNode? {
        if preLeft > preRight || inLeft > inRight {
            return nil
        }
        
        guard let pIndex = inMap[preorder[preLeft]] else {
            return nil
        }
        let root = TreeNode(preorder[preLeft])
        root.left = build(preorder, preLeft + 1, pIndex - inLeft + preLeft, inorder, inLeft, pIndex - 1, inMap)
        root.right = build(preorder, pIndex - inLeft + preLeft + 1, preRight, inorder, pIndex + 1, inRight, inMap)
        return root
    }
}
