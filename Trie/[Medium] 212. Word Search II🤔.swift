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

// faster than 49.77%
// 这题是 79 题的进阶版本，在 79 的基础上稍作修改
// 思考的时候想的是在 79 题 i，j 的二层循环上，再加上一个 words 循环，每个单词都重新调用一次 dfs，但是显然效率太低
// 有效的方式应该还是使用 i，j 两层循环去调用 dfs，在 dfs 的过程中记录到目前为止所形成的单词，看这个单词是否在 trie 中
class Solution {
    let dir = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        guard words.count > 0 else {
            return []
        }
        let trie = Trie()
        var result = Set<String>() // 注意这里要用 set，因为可能会组合出相同的单词，不能重复添加
        
        // 将所有单词插入 trie
        for word in words {
            trie.insert(word)
        }
        // 因为每个位置的字符在一个单词中只能出现一次，所以需要一个 visited 数组在 dfs 中过滤掉重复字符
        var visited = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
        
        /// --------------------------------------------
        // dfs 和 79 题有点不一样，多了一个 curWord 参数，代表路径走到这里所组成的单词是什么，每次判断当前组成的单词是不是在 trie 中
        func dfs(_ i: Int, _ j: Int, _ curNode: Node, _ curWord: String) {
            // 如果 node 中不存在指定位置字符，直接返回
            if !trie.search(board[i][j], curNode) {
                return
            }
            // 如果当前的 node 不包含 i j 位置上的字符，那么就不用再往下查找了
            guard let child = curNode.children[board[i][j]] else {
                return
            }
            // 如果指定字符存在，且是单词的结尾，说明在矩阵中存在单词
            if child.isTerminating {
                result.insert(curWord + String(board[i][j]))
            }
            
            // 按照四个方位依次尝试
            for d in dir {
                let m = i + d.0
                let n = j + d.1
                if m >= 0 && m < board.count && n >= 0 && n < board[0].count && visited[m][n] == false {
                    visited[m][n] = true
                    dfs(m, n, child, curWord + String(board[i][j]))
                    visited[m][n] = false
                }
            }
        }
        /// --------------------------------------------
        
        for i in 0 ..< board.count {
            for j in 0 ..< board[i].count {
                // 注意这里也需要对 visited 设置
                visited[i][j] = true
                dfs(i, j, trie.root, "")
                visited[i][j] = false
            }
        }
        return Array(result)
    }
}

let s = Solution()
print(
s.findWords([
  ["o","a","a","n"],
  ["e","t","a","e"],
  ["i","h","k","r"],
  ["i","f","l","v"]
], ["oath","pea","eat","rain", "oath"]))
print("done")
