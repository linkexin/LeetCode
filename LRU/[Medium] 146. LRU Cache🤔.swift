class LinkNode<KT, VT> {
    let key: KT
    var value: VT
    var pre: LinkNode?
    var next: LinkNode?
    
    init(_ key: KT, _ value: VT) {
        self.key = key
        self.value = value
    }
}

// 字典 + 链表的形式，put 操作通过链表可以实现 O(1)，而 get 需要借助字典来实现 O(1)
class LRUCache {
    typealias Node = LinkNode<Int, Int>
    var head: Node
    var rear: Node
    
    var map = [Int: Node]()
    var count = 0
    let capacity: Int

    init(_ capacity: Int) {
        head = Node(-1, -1)
        rear = Node(-1, -1)
        head.next = rear
        rear.pre = head
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        guard let node = map[key] else {
            return -1
        }
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if map[key] != nil {
            let node = map[key]!
            node.value = value // 记得这里要更新 value
            moveToHead(node)
        } else {
            let node = Node(key, value)
            map[key] = node
            insertNode(node)
        }
        if count > capacity {
            map.removeValue(forKey: rear.pre!.key)
            removeNode(rear.pre!)
        }
    }
    
    // 插入到链表的最前面
    func insertNode(_ node: Node) {
        head.next?.pre = node
        node.next = head.next
        node.pre = head
        head.next = node
        count += 1
    }
    
    func removeNode(_ node: Node) {
        // 原本写成了下面2行，结果 WA 了，
        // 需要注意 removeNode 的地方有两处，不一定就是 remove 最后一个元素，所以不能直接用 rear 操作
//        node.pre?.next = rear
//        rear.pre = node.pre
        node.pre?.next = node.next
        node.next?.pre = node.pre

        count -= 1
    }
    
    func moveToHead(_ node: Node) {
        removeNode(node)
        insertNode(node)
    }
    
    func printLink() {
        var node: Node? = head
        print("---")
        while node != nil {
            if node?.value != -1 {
                print(node?.key ?? -11, node?.value ?? -11)
            }
            node = node?.next
        }
        print("---")
    }
}
