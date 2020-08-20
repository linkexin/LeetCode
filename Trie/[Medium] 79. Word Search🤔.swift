class TrieNode<T: Hashable> {
    var value: T?
    var children = [T: TrieNode]()
    var isTerminating = false
    
    init(_ value: T? = nil) {
        self.value = value
    }
}

typealias Node = TrieNode<Character>
class Trie {
    var root = Node()
    
    func insert(_ word: String) {
        var currentNode = root
        for c in word {
            if currentNode.children[c] == nil {
                currentNode.children[c] = Node(c)
            }
            currentNode = currentNode.children[c] ?? Node()
        }
        currentNode.isTerminating = true
    }
    // 在本题中无用
    func search(_ word: String) -> Bool {
        var currentNode = root
        for c in word {
            if currentNode.children[c] == nil {
                return false
            }
            currentNode = currentNode.children[c] ?? Node()
        }
        return currentNode.isTerminating
    }
    // 为了本题新加的方法，看字符在指定 node 中是否存在
    func search(_ character: Character, _ node: Node) -> Bool {
        return node.children[character] != nil
    }
}

// faster than 67.34%
// 一开始一直在想怎么样将矩阵中所有可能的单词都输入到 trie 中，其实也可以，无非也就是 dfs，但是 trie 应该会比较大，特别是题目中说了，最大矩阵是 200 * 200
// 后来看到输入给定的 word，然后 dfs 矩阵去解题，就觉得思路很妙，自己没想到
class Solution {
    let dir = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let trie = Trie()
        trie.insert(word)
        // 因为每个位置的字符在一个单词中只能出现一次，所以需要一个 visited 数组在 dfs 中过滤掉重复字符
        var visited = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
        
        func dfs(_ i: Int, _ j: Int, _ node: Node) -> Bool {
            // 如果 node 中不存在指定位置字符，直接返回
            if !trie.search(board[i][j], node) {
                return false
            }
            let child = node.children[board[i][j]] ?? Node()
            // 如果指定字符存在，且是单词的结尾，说明在矩阵中存在单词
            if child.isTerminating {
                return true
            }
            
            // 按照四个方位依次尝试
            for d in dir {
                let m = i + d.0
                let n = j + d.1
                if m >= 0 && m < board.count && n >= 0 && n < board[0].count && visited[m][n] == false {
                    visited[m][n] = true
                    if dfs(m, n, child) {
                        return true
                    }
                    visited[m][n] = false
                }
            }
            return false
        }
        
        
        for i in 0 ..< board.count {
            for j in 0 ..< board[i].count {
                // 注意这里也需要对 visited 设置
                visited[i][j] = true
                if dfs(i, j, trie.root) {
                    return true
                }
                visited[i][j] = false
            }
        }
        return false
    }
}

let s = Solution()
print(
s.exist([
  ["A","B","C","E"],
  ["S","F","C","S"],
  ["A","D","E","E"]
], ""))
print("done")
