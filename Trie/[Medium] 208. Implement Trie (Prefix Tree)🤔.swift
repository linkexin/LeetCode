// 字典树的实现参考了：https://github.com/raywenderlich/swift-algorithm-club/blob/master/Trie/Trie/Trie/Trie.swift
class TrieNode<T: Hashable> {
    let value: T? // value 不一定有值, root 就没有值
    var children = [T: TrieNode]()
    var parentNode: TrieNode<T>? // 本题中用不到
    var isTerminating = false
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(_ value: T? = nil, _ parent: TrieNode<T>? = nil) {
        self.value = value
        self.parentNode = parent
    }
    
    func addChild(_ value: T) {
        guard children[value] == nil else {
            return
        }
        children[value] = TrieNode(value, self)
    }
    
}

class Trie {
    typealias Node = TrieNode<Character>
    let root: Node
    var wordCount: Int

    init() {
        root = Node()
        wordCount = 0
    }
    
    func insert(_ word: String) {
        guard word.isEmpty == false else {
            return
        }
        var currentNode = root
        for c in word.lowercased() {
            if let childNode = currentNode.children[c] {
                currentNode = childNode
            } else {
                currentNode.addChild(c)
                currentNode = currentNode.children[c] ?? Node()
            }
        }
        // 因为这里会计算单词数，所以需要判断 isTerminating 是否已经为 true，防止重复添加同一个单词的时候，wordCount 不正确
        guard currentNode.isTerminating == false else {
            return
        }
        wordCount += 1
        currentNode.isTerminating = true
    }
    
    func search(_ word: String) -> Bool {
        guard word.isEmpty == false else {
            return false
        }
        var currentNode = root
        for c in word {
            guard currentNode.children[c] != nil else {
                return false
            }
            currentNode = currentNode.children[c] ?? Node()
        }
        return currentNode.isTerminating
    }
    
    // startsWith 和 search 放个方法就差在最后一句
    func startsWith(_ prefix: String) -> Bool {
        guard prefix.isEmpty == false else {
            return false
        }
        var currentNode = root
        for c in prefix {
            guard currentNode.children[c] != nil else {
                return false
            }
            currentNode = currentNode.children[c] ?? Node()
        }
        return true
    }
}
