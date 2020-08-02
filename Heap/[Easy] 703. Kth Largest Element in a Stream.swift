
extension Int {
    var parent: Int {
        return (self - 1) / 2
    }
    
    var leftChild: Int {
        return self * 2 + 1
    }
    
    var rightChild: Int {
        return self * 2 + 2
    }
}

struct Heap<ElementType> {
    var elements = [ElementType]()
    var priority: (ElementType, ElementType) -> Bool
    init(_ priority: @escaping (ElementType, ElementType) -> Bool) {
        self.priority = priority
    }
    
    func count() -> Int {
        return elements.count
    }
    
    func first() -> ElementType? {
        return elements.first
    }
    
    mutating func push(_ ele: ElementType) -> ElementType? {
        elements.append(ele)
        shiftUp()
        return elements.first
    }
    
    // 最后一个元素向上移动，来恢复堆的顺序
    mutating func shiftUp() {
        var child = elements.count - 1
        var parent = child.parent
    
        while parent != child && !priority(elements[parent], elements[child]) {
            swap(parent, child)
            child = parent
            parent = child.parent
        }
    }
    
    // 将指定元素向下移动，来恢复堆的顺序
    mutating func shiftDown(_ index: Int) {
        var parentIndex = index
        while true {
            var minChildIndex = parentIndex.leftChild
            if minChildIndex >= count() {
                return
            }
            
            if parentIndex.rightChild < count() && priority(elements[parentIndex.rightChild], elements[minChildIndex]) {
                minChildIndex = parentIndex.rightChild
            }
            
            if priority(elements[minChildIndex], elements[parentIndex]) {
                swap(minChildIndex, parentIndex)
                parentIndex = minChildIndex
            } else {
                return
            }
        }
    }
    
    mutating func replace(_ ele: ElementType) -> ElementType? {
        elements[0] = ele
        shiftDown(0)
        return elements.first
    }
    
    mutating func swap(_ index1: Int, _ index2: Int) {
        let temp = elements[index1]
        elements[index1] = elements[index2]
        elements[index2] = temp
    }
}


// faster than 100.00%，less than 100.00%
class KthLargest {
    var heap: Heap<Int>
    var k: Int
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        heap = Heap<Int>( < )
        for n in nums {
            _ = add(n)
        }
        self.k = k
    }
    
    func add(_ val: Int) -> Int {
        // 堆中元素小于 k 就直接 push
        if heap.count() < k {
            return heap.push(val) ?? 0
        }
        // 堆中元素大于 k，且堆中的最小元素(堆顶元素) < 新值，则替换堆中的最小元素为最新值
        if heap.first() ?? Int.min < val {
            return heap.replace(val) ?? 0
        }
        // 堆中元素大于 k，且堆中的最小元素(堆顶元素) > 新值，什么都不用操作，直接返回堆顶元素
        return heap.first() ?? 0
    }
}

let k = 3
let arr = [4,5,8,2]
let kthLargest = KthLargest(k,arr)
print(kthLargest.add(3))   // returns 4
print(kthLargest.add(5))   // returns 5
print(kthLargest.add(10))  // returns 5
print(kthLargest.add(9))   // returns 8
print(kthLargest.add(4))   // returns 8
