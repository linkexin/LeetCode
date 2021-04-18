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

// 初始化的时候就将中序遍历的数组生成，后续调用 next 和 hasNext 的时候就可以直接使用数组实现 O(1)
class BSTIterator {
    let root: TreeNode?
    var current = 0
    var inOrder = [Int]()
    
    init(_ root: TreeNode?) {
        self.root = root
        genarateInorder(root)
    }
    
    // 非递归写法的中序遍历
    func genarateInorder(_ root: TreeNode?) {
        var node = root
        var stack = [TreeNode?]()
        
        while node != nil || !stack.isEmpty {
            while node != nil {
                stack.append(node)
                node = node?.left
            }
            let top = stack.removeLast()
            inOrder.append(top!.val)
            node = top?.right
        }
    }
    
    func next() -> Int {
        if current >= inOrder.count {
            return -1
        }
        let val = inOrder[current]
        current += 1
        return val
    }
    
    func hasNext() -> Bool {
        return current < inOrder.count
    }
}

let l1 = TreeNode(1)
let l2 = TreeNode(2)
let l3 = TreeNode(3)
let l4 = TreeNode(4)
let l5 = TreeNode(5)
let l6 = TreeNode(6)
l1.right = l2
l2.left = l3
l2.right = l4
l4.left = l5
l5.right = l6
let s = BSTIterator(l1)
print(s.next())
print(s.next())
print(s.hasNext())
print(s.next())
print(s.hasNext())
print(s.next())
print(s.hasNext())
print(s.next())
print(s.hasNext())
